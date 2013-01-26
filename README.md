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
  

`Company` for the companies tracked
