// On créé un VPC avec utilisant le CIDR définit dans les variables
resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true

    tags {
        Name = "vpc-project",
        Department = "",
        ProjectName = "project"
    }
}

// Création d'une ressource Internet GW
resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
    tags {
        Name = "gateway-project",
        Department = "",
        ProjectName = "project"
    }
}

// Définition du sous-réseau
resource "aws_subnet" "eu-west-3a" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.subnet_cidr}"
    availability_zone = "${var.availability_zone}"

    tags {
        Name = "subnet-project",
        Department = "",
        ProjectName = "project"
    }
}


// Création d'une ressource route table (table de routage)
resource "aws_route_table" "eu-west-3a" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "rt-project",
        Department = "",
        ProjectName = "project"
    }
}

// On ajoute notre entrée dans la "route table"
resource "aws_route_table_association" "eu-west-3a" {
    subnet_id = "${aws_subnet.eu-west-3a.id}"
    route_table_id = "${aws_route_table.eu-west-3a.id}"
}


// Création d'un groupe de sécurité "Security Group"
resource "aws_security_group" "project" {
    name = "vpc-project"
    description = "Allow incoming SSH connections."

    // on autorise la connexion ssh depuis 0.0.0.0/0
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    // tout ce qui n'est pas autorisé est interdit
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "sg-project",
        Department = "",
        ProjectName = "project"
    }
}











// Instance EIB EBS
resource "aws_volume_attachment" "project-dso-1" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.project-dso-1.id}"
  instance_id = "${aws_instance.project-dso-1.id}"
}

//  Création d'une ressource ec2
resource "aws_instance" "project-dso-1" {
    ami = "${lookup(var.amis, var.aws_region)}"
    instance_type = "t2.small"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.project.id}"]
    subnet_id = "${aws_subnet.eu-west-3a.id}"
    associate_public_ip_address = true
    source_dest_check = false
    root_block_device {
      volume_size = "8"
    }
    tags {
        Name = "ec2-project-dso-1",
        Department = "",
        ProjectName = "project"
    }
}

// Création d'une adresse IP elastic
resource "aws_eip" "project-dso-1" {
    instance = "${aws_instance.project-dso-1.id}"
    vpc = true
    tags {
        Name = "eip-project-1",
        Department = "",
        ProjectName = "project"
    }
}

// Création d'un volume
resource "aws_ebs_volume" "project-dso-1" {
    availability_zone = "${var.availability_zone}"
    size = 12
    type = "gp2"
    tags {
        Name = "ebs-project-dso",
        Department = "",
        ProjectName = "project"
    }
}
