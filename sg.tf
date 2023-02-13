resource "aws_security_group" "assignment-alb-sg" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "${local.env}-${local.application}-alb"
}

resource "aws_security_group_rule" "assignment-alb-allow-http" {
  type              = "ingress"
  from_port         = 81
  to_port           = 81
  protocol          = "TCP"
  cidr_blocks       = local.aws_ingress_cidr
  security_group_id = aws_security_group.assignment-alb-sg.id
}

resource "aws_security_group_rule" "assignment-alb-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "UDP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.assignment-alb-sg.id
}

resource "aws_security_group" "assignment-alb-sg-containers" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "${local.env}-${local.application}-containers"
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # Only allowing traffic in from the load balancer security group
    security_groups = [aws_security_group.assignment-alb-sg.id]
  }

  egress {
    from_port = 0    # Allowing any incoming port
    to_port   = 0    # Allowing any outgoing port
    protocol  = "-1" # Allowing any outgoing protocol 
    #security_groups = [aws_security_group.assignment-alb-sg.id]
    cidr_blocks = ["192.168.0.0/24"]
  }
}
