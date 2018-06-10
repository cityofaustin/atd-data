## AWS load balancer + SSL
To configure a load balancer + SSL for postgresql/postgrest instance on AWS EC2, start by creating an "application" load balancer on the same VPC as your postgrest EC2 instance.

You will add "listeners" to the load balancer which forward network traffic to "target" EC2 postgrest instance. Listeners should listen for traffic on port 80 and 443, and forward both to port 80 (or whatever port postgrest is listening to) on the postgrest EC2 instance.

When configuring the HTTPS (443) listener, specify an SSL cert use. (We're currently using the global austintexas.io cert).

Lastly, create a Route 53 CNAME rule to associate your subdomain with the load balancer address. 