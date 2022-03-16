resource "aws_security_group" "bastion_ssh_all_sg_darwin" {
    
    name            = "bastion_ssh_all_sg_darwin"
    description     = "Allow SSH from Anywhere"
    vpc_id          = aws_vpc.vpcdarwin.id #module.site.output_vpc_id 

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [var.any_ip]
    }

    egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = [var.any_ip]

    }

    tags            = {
        
    Name            = "Bastion Allow All_Darwin"
    }

     
  
}

output "output_bastion_ssh" {
  value = aws_security_group.bastion_ssh_all_sg_darwin.id
}

## SSH from Bastion

resource "aws_security_group" "bastion_ssh_from_nat" {
    name             = "ssh_from_bastion_nat"
    description      = "Allow SSH from Bastion Host"
    vpc_id           = aws_vpc.vpcdarwin.id 

    ingress {
     from_port       = 22
     to_port         = 22
     protocol        = "tcp"
     security_groups = [
                        aws_security_group.bastion_ssh_all_sg_darwin.id,
                        aws_security_group.web_from_nat_prv_sg.id

     ]
    }
  
}

output "bastion_ssh_from_nat" {
  value = aws_security_group.bastion_ssh_from_nat.id
}




# External Application Load Balancer

resource "aws_security_group" "external_alb_sg" {
    
    name        = "external_alb_sg"
    description = "Allow port 80 from Anywhere"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [var.any_ip]
    }

    egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = [var.any_ip]

    }

    tags            = {
        
    Name            = "External Load Balancer Security Group"
    }

    vpc_id          = aws_vpc.vpcdarwin.id #module.site.output_vpc_id  
  
}

output "output_external_alb_sg" {
  value = aws_security_group.external_alb_sg.id
}

# Internal Application Load Balancer

resource "aws_security_group" "internal_alb_sg" {
    
    name        = "internal_alb_sg"
    description = "Allow port 3000 from Private"

    ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        cidr_blocks = [var.private_subnet_3]
    }

      ingress {
        from_port   = 3000
        to_port     = 3000
        protocol    = "tcp"
        cidr_blocks = [var.private_subnet_4]
    }

    egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = [var.private_subnet_3]

    }

     egress {
        from_port   = "0"
        to_port     = "0"
        protocol    = "-1"
        cidr_blocks = [var.private_subnet_4]

    }
