Problem Statement:
A three-tier architecture is a software architecture pattern where the application is broken down into three logical tiers: the presentation layer, the business logic layer and the data storage layer.

Approach:
Shifting the security to the left, I will be desiging the infrastuture with one VPC with 4 subnets with combination of private and public for various layers. In addition to that there will be a bastion host and a NAT gateway for the admins to have access to the infrastructure. I am also going to create a Auto scaling group across two availbality zones for fault tolerance and high availablity (Real SLA of 99.99%).


Steps need to action:

VPC
Internet gateway
4 Subnets (2 public and 2 private in 2 AZ's)
Create two Route tables (public for internet and private for the traffic through NAT Gateway)
Create NAT Gateway
ELB (Internet and the Internal Load balancer)
Auto Scaling group
Bastion Host

