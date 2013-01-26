# About Trackr

Trackr /t'rækə(r)/ is a simple web application to track contact with companies written in Ruby on Rails.

## Motivation

The motivation came out of the problem of knowledge transfer that was very much a problem at Students' Placement Office, IIT Kanpur. Every year the placement team was composed of almost all new students with 1 or 2 common persons, which meant "Knowledge Transfer" between batches were important. The methods adopted were
1. Google docs
2. Reading mail archives
3. Contacting last year's team.

Clearly a better solution was needed. Trackr was thus born. 

## Models

`User` are the user that will be allowed access to the site contains
- `Username/Password/Salt` in typical RoR fashion
- `Email` currently restricted to @iitk.ac.in
- `Userlevel` - A number with 0 being admin and in general lower number indicates higher authrority. 

    In future we plan to have a authorization module which will be roughly associate a `number` of the model of chmod in linux to the entries. Where authorization has values from 
        + 0 - Not visible
        + 1 - Read
        + 2 - Edit subject to Authorization
        + 4 - Edit without Authorization
        + 8 - Authorize edits

- `Phone Number` - Stores user phone number
- `Identifier` - Used to store unique identifier for the user, which is roll number in our case. 

- HasMany:`tags`- Tags are generalizations for making groups of people and users 


`Company` for the companies tracked which has 
- `Name`
- `Link`
- `Phone number`
- `Location`
- `Address`
- `Point of Contact` - User_id of the person assigned to the company
- `Managed by` - User_id of the person managing it. 
- `Status` - Which stage it has reached, identified by code numbers
- `Summary`- The total summary of the company till now

- HasMany: `tags`
- HasMany: `Company_log`
- HasMany: `Company_contacts`

`Company_log` - Contains the content of the company log interaction 
- `Contacted by`
- `Company-contact`
- `Time Stamp`
- `Tone` - Very positive to very negative
- `Content` - What was the conversation that happened

`Company_contact` - Has the details of the company persons 
- `Name` 
- `Designation`
- `Landline`
- `Mobile phone`
- `Email Id`
- `Address`

`Tags` is a special kind of model I still haven't decided the method to implement since it is used BOTH for companies and users and we need the function to find the users who have the same tags as companies
- `Tag Name`
- `Tag Description`
- `company_id`
- `user_id`
- `Company/User`





