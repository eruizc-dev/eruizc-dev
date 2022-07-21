# Google Cloud Fundamentals: Core Infrastructure

### What's the cloud?

A wait of using IT that has these five traits:
 1. Computing resources on-demand and self-service
 2. Access to resources over the internet, from anywhere
 3. Big pool of resources to allocate to users
 4. Resources elastic, so customers can be (to escale)
 5. Customers pay for what they use

### Why is it relevant now?

Timeline (in waves):
 1. Collocation: rent physical space
   - Economic benefits over investing in private datacenters
 2. Virtuallized Datacenter: use of virtual devices
   - Give more controll to users
   - IaaS and PaaS
 3. Container-based: elastic and automatic
   - More partitioned and automaticly scalable solutions

## Google's Infrastructure

### Location

<https://cloud.google.com/about/locations>

One in every major location, composed by regions. Examples:
 - North America
 - South America
 - Europe
 - Asia
 - Australia

### Region

Indepentend geographic areas, composed of zones. Examples:
 - europe-west2

### Zones

Area where clod resources are deployed.
 - europe-west2-a
 - europe-west2-b
 - europe-west2-c

### Multi-region

Use multiple locations and regions for redundancy and improved response times. Some GCloud services support multi-region for redundancy, that means
using 2 or more regions separated by at least 160km.

## Available services

### Infrastructure as a Service (IaaS)

 - Pay for what you allocate
 - Provides virtual computing, storage and network

###  Platform as a Service (PaaS)

 - Pay for what you use
 - Provides virtual computing, storage and network
 - No infrastructuree management needed

### Software as a Service (SaaS)

Not installed in your computer, they run in cloud infra and you use them
through the internet

## Pricing

 - Per second billing
 - Sustained-use discounts in some services
 - [Calculator](https://cloud.google.com/products/calculator)
 - Prevent over-spending:
   - Budgets
   - Alerts
   - Reports
   - Quotas: rate and allocation. Some quotas set by default.

## Structure and permissions

4 Levels: Organization -> Folders -> Projects -> Resources

### Projects

 - Separate entities under the organization
 - Hold resources, each of which belongs to only one Project
 - Different owners and users
 - Billed separately
 - Can br grouped in folders

Identifiers:
 - ID
   - Globally unique
   - Assigned by user during creation
   - Immutable after creation
 - Name
   - Not unique
   - Chosen by you
   - Mutable
 - Number
   - Globally unique
   - Assigned by Google
   - Immutable

### IAM

 - Role-based permissions
 - Policies apply down the hierarchy

Three types:
 - Basic: predefined for all resources in a project
   - Owner: read, write, configure, billing
   - Editor: read, write
   - Viewer: read
   - Biling Admin: read, billing
 - Predefined: predefined per resource action
 - Custom: create as you wish
   1. You need to manage the permissions
   2. Only applied at project or organization level, not folder

### Cloud Identity

Organization can define policies and manage their users with the Google
Admin Console. Manage with Active Directory / Ldap.

## Interacting with Google Cloud

Accessible from:

 - Cloud Console
   - Web GUI
   - Easily find and control resources
   - Billing management
 - Cloud SDK and Cloud Shell:
   - gcloud tool: main CLI
   - gsutil: access Cloud Storage from CLI
   - bq: access Big Query from CLI
 - APIs
   - Provides command-line access to cloud resources from a browser
   - CloudSDK always installed and updated
   - Can write code to access them
   - Google APIs Explorer can help you navigate
   - Client libraries available
 - Cloud Console Mobile App
   - GUI for mobile devices

# References

Course Introduction
 1. [Course Introduction](https://youtu.be/dUpXhlAFM2Y)

Introducing Google Cloud
 1. [Cloud computing overview](https://youtu.be/1xxiFQXJ_t0)
 2. [IaaS and PaaS](https://youtu.be/RjPmBJ3pK88)
 3. [The Google Cloud network](https://youtu.be/r-FkARxitwM)
 4. [Environmental impact](https://youtu.be/-CZLM-i6xIg)
 5. [Security](https://youtu.be/qNDfXX0gIi8)
 6. [Open source ecosystems](https://youtu.be/625-RzHG-eQ)
 7. [Pricing and billing](https://youtu.be/VSFyBnpspxY)
 8. Quiz

Resources and access in the Cloud
 1. [Google Cloud resource hierarchy](https://youtu.be/t1eoWIW3z1s)
 2. [Identity and Access Management (IAM)](https://youtu.be/EQJTp0uu148)
 3. [Service accounts](https://youtu.be/JulGSEycLXc)
 4. [Cloud Identity](https://youtu.be/PC6DL__6yRg)
 5. [Interacting with Google Cloud](https://youtu.be/AHACrzN_9FQ)
 6. Lab
 7. Quiz
