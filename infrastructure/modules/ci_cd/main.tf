resource "aws_codecommit_repository" "crm" {
  repository_name = var.repository_name
  description = "CRM application repository"
}

resource "aws_ecr_repository" "server" {
  name = "twenty-server"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "worker" {
  name = "twenty-worker"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_codebuild_project" "build" {
  name = var.build_project_name
  description = "CRM build project"
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    type = "LINUX_CONTAINER"
    image = "aws/codebuild/standard:6.0"
    compute_type = "BUILD_GENERAL1_MEDIUM"
    privileged_mode = true
    image_pull_credentials_type = "CODEBUILD"

    environment_variable {
      name = "AWS_ACCOUNT_ID"
      value = var.account_id
    }
    
    environment_variable {
      name = "AWS_DEFAULT_REGION"
      value = var.region
    }
  }

  source {
    type = "CODEPIPELINE"
    buildspec = file("${path.module}/buildspec.yaml")
  }
}

resource "aws_codepipeline" "crm" {
  name = var.pipeline_name
  role_arn = aws_iam_role.codepipeline.arn

  artifact_store {
    location = aws_s3_bucket.artifacts.bucket
    type = "S3"
  }

  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeCommit"
      version = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = aws_codecommit_repository.crm.repository_name
        BranchName = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name  = "Build"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      input_artifacts = ["source_output"]
      output_artifacts = ["build_output"]
      version = "1"

      configuration = {
        ProjectName = aws_codebuild_project.build.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name = "Deploy"
      category = "Deploy"
      owner = "AWS"
      provider = "ECS"
      input_artifacts = ["build_output"]
      version = "1"

      configuration = {
        ClusterName = var.ecs_cluster_name
        ServiceName = var.ecs_service_name
        FileName = "imagedefinitions.json"
      }
    }
  }
}

resource "aws_s3_bucket" "artifacts" {
  bucket = "${var.pipeline_name}-artifacts"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "artifacts" {
  bucket = aws_s3_bucket.artifacts.id
  acl = "private"
}

resource "aws_iam_role" "codebuild" {
  name = "crm-codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "codebuild" {
  role = aws_iam_role.codebuild.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchDeleteImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:PutObject"
        ],
        Resource = "${aws_s3_bucket.artifacts.arn}/*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "codepipeline" {
  name = "crm-codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "codepipeline" {
  role = aws_iam_role.codepipeline.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:GetObjectVersion",
          "s3:GetBucketVersioning",
          "s3:PutObjectAcl",
          "s3:PutObject"
        ],
        Resource = [
          aws_s3_bucket.artifacts.arn,
          "${aws_s3_bucket.artifacts.arn}/*"
        ]
      },
      {
        Effect = "Allow",
        Action = [
          "codecommit:GetBranch",
          "codecommit:GetCommit",
          "codecommit:UploadArchive",
          "codecommit:GetUploadArchiveStatus",
          "codecommit:CancelUploadArchive"
        ],
        Resource = aws_codecommit_repository.crm.arn
      },
      {
        Effect = "Allow",
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecs:DescribeServices",
          "ecs:DescribeTaskDefinition",
          "ecs:RegisterTaskDefinition",
          "ecs:UpdateService"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = "iam:PassRole",
        Resource = "*"
      }
    ]
  })
}