### Sub Domain hosted in Route 53


1) Create The following Public Hosted Zone in your AWS Account i.e:
```
 - project1.test.example.com
   - Comment: My Local Test
 - k8s.project1.test.example.com                                     <- This is were all kubernetes records will be contained.
   - Comment: Kubernetes Operational Management

 - Go into `project1.test.example.com` hosted zone
   - Create Record Set (k8s.project1.test.example.com)
   - Type: NS - Name Server
   - TTL (Seconds) 900
   - Value: <Paste your NS records in here>



2) Take the NS record outputs as you will need these to create Route Delegation to this new zone which is contained within Route 53.

take the following action:
```
 - Go into `test.example.com` hosted zone
 - Create Record Set (e.g: `project1.test.example.com`)
   - Type: NS - Name Server
   - TTL (Seconds) 900
   - Value: <Paste your NS records in here>
```
