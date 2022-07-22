# 4-networks

This repo is part of a multi-part guide that shows how to configure and deploy
the ideanomics.com reference architecture.


<table>
<tbody>
<tr>
<td>1.bootstrap</td>
<td>Bootstraps a Google Cloud organization, creating all the required resources
and permissions to start using the Cloud Foundation Toolkit (CFT). This
step also configures a CI/CD pipeline for foundations code in subsequent
stages.</td>
</tr>
<tr>
<td>2.org</td>
<td>Sets up top level shared folders, monitoring and networking projects, and
organization-level logging, and sets baseline security settings through
organizational policy.</td>
</tr>
<tr>
<td>3.environments</td>
<td> non-production, and production environments within the
Google Cloud organization that you've created.</td>
</tr>
<tr>
<td>4.networks(this repo)</td>
<td>Sets up base  shared VPCs with  NAT,
Private Service networking, serverless vpc connector, and baseline firewall rules for each environment. </td>
</tr>
<tr>
<td>5.projects </td>
<td>Sets up a folder structure, projects, and application infrastructure pipeline for applications,
 which are connected as service projects to the shared VPC created in the previous stage.</td>
</tr>
<tr>
</tr>
</tbody>
</table>
 
 


 
 
## Purpose

The purpose of this step is to:

Sets up base  shared VPCs with  NAT,
Private Service networking, serverless vpc connector and baseline firewall rules for each environment.

## Prerequisites

1. bootstrap executed successfully.
1. org executed successfully.
1. environments executed successfully.
