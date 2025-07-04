# Emergency Recovery—Manual RDS Restore & Failover

If the automated CloudWatch → Lambda promotion of read-replica fails, recover by manually promoting the replica or restoring from AWS Backup:

---

## 1. Confirm Primary Outage & Replica State

1. **Check Primary**
   - In the RDS Console (primary region), verify if the primary instance is down.
2. **Check Replica**
   - In the DR region (`ap-southeast-1`), locate read-replica (`<prefix>-db-replica`).
   - If **available**, skip to Step 2.
   - If **not available**, proceed to Step 3.

---

## 2. Manually Promote the Read-Replica

```bash
aws rds promote-read-replica \
  --region ap-southeast-1 \
  --db-instance-identifier "<prefix>-db-replica"
```

- Wait until the instance is available (no “replica” label).
- Go to Step 5 to redirect application/DNS.

## 3. Restore from AWS Backup (if replica is gone)

- In the AWS Backup Console select RDS instance ARN.
- Under Recovery points, find the latest backup in primary vault (or secondary if >90 days old).
- Click Restore and configure:
  - Target region: `ap-southeast-1`
  - DB identifier: `<prefix>-emergency-restore`
  - Instance class, subnet group, security groups: match primary settings
- Wait for Status → Completed.

## 4. Apply Parameter Groups & Tags

```bash
aws rds modify-db-instance \
  --db-instance-identifier "<prefix>-emergency-restore" \
  --db-parameter-group-name crm-pg-15 \
  --apply-immediately
```

Re-apply any tags, backup retention, or maintenance window settings.

## 5. Redirect Application / DNS

1. Route 53

- Edit the DNS record for the DB endpoint (e.g. db.crm.example.com) to point at the new endpoint.

2. Verify Connectivity

```bash
psql "host=<new-endpoint> port=5432 dbname=<db_name> user=<db_username> sslmode=require"
```

Run a test query to confirm read/write access.

### 6. Re-Enable Backups & Replication

Re-create Read Replica (if you promoted manually):

```bash
aws rds create-db-instance-read-replica \
  --region ap-southeast-1 \
  --db-instance-identifier "<prefix>-db-replica-2" \
  --source-db-instance-identifier "<prefix>-emergency-restore"
```

In the AWS Backup Console, confirm the Backup Plan and selections still include the new instance.

## 7. Clean Up & Post-Mortem

- Delete any temporary/emergency DB instances once primary is healthy.
- Inspect CloudWatch Logs for the Lambda failover function to diagnose the auto-promotion failure.
- Test this recovery procedure periodically.
