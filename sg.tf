resource "aws_security_group" "alb-public" {
  name        = "roboshop-public-${var.ENV}-alb-sg"
  description = "allow http inbound traffic from internet only"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID


  ingress {
    description      = "alow http from internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-public-${var.ENV}-alb-sg"
  }
}

resource "aws_security_group" "alb-private" {
  name        = "roboshop-private-${var.ENV}-alb-sg"
  description = "allow traffic only from public LB"
  vpc_id      = data.terraform_remote_state.vpc.outputs.VPC_ID


  ingress {
    description      = "alow http from intranet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [data.terraform_remote_state.vpc.outputs.VPC_CIDR]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "roboshop-private-${var.ENV}-alb-sg"
  }
}