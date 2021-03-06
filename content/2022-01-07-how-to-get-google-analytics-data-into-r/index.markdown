---
title: How to Get Google Analytics Data into R
author: Aleksa Bozicic
date: '2022-01-07'
slug: []
categories:
  - Google Analytics
tags:
  - ga
  - r
  - api
---

## Intro

In this post I will introduce you to the basics of interacting with Google Analytics API trough R.
You will learn a bit about GA API, and I will show you resources you can use to learn more.

You don't need any R knowledge, but I do expect you to be able to install software on your own, and to have familiarity with UA GA properties.

Let's get started.

## Quick Overview of GA API
In this post we will be talking about [Reporting API v4](https://developers.google.com/analytics/devguides/reporting/core/v4).

This is the API used to interact with "old" UA properties, we will not talk about new GA4 properties nor Data API (currently in beta).

If you don't know what an API is, you can think of it as a end point to which you supply some parameters and then the API returns something back. 
APIs are everywhere, they are what enables different websites/apps/computers to talk to each other.
In some later posts I will teach you how you can build an interactive Shiny app that talks to the various Google APIs.

In the case of GA API you need to supply following parameters:
* Metrics
* Dimensions
* Filters
* Date Range
* ViewId (sometimes referenced as table id)

There are some other parameters that determine how many rows an API will return, but these parameters are fine for now. 

So once you provide these parameters to the GA API it will return back data to you.

## Making Your First GA API Call
Here I will introduce you to one of my favorite tools called [UA Query Explorer](https://ga-dev-tools.web.app/query-explorer/).

This tool allows you to interact with your UA properties trough GA API.

Now let's make the first API call. 

You need to authenticate and give permission to this tool to see your GA data. 

Once that's done select a property and a view for which you want to extract the data.

Let's keep it simple for now and ask an API to give us number of users per day for last 7 days.

Your query should look like this.

Your First GA API Query: ![](query.png) 

Please note that in general when we say **query** we are referencing a specific set of parameters that are being supplied to the API.

If everything worked you should see a table of data returned from the API at the bottom of the page.

This tool is great if you want to quickly validate some queries and it's a great way to get your toes wet without installing any additional software. 

I highly suggest you familiarize yourself with metrics and dimensions available in GA API.
Some combinations of metrics and dimensions are not supported. 
For this you can use [UA Dimensions & Metrics Explorer](https://ga-dev-tools.web.app/dimensions-metrics-explorer/).

## Doing it from R
### Why would you want to do this from R?
There are several reasons, but one of the main ones is reproducibility.

Lets say every week you are pulling some data from your GA account into Google Sheets, you do some transformations on this data, and finally you make a report that you deliver to your boss/client.

R can help you automate every step of this process from data extraction to transformation to creating a beautiful report in either html or pdf format.

You only have to write the script once, validate the result, and then from there the whole process can be scheduled and automated.

In this specific post I will teach you how you can extract the data from GA API, but in some later posts I will talk about other steps mentioned above as well.

### Requirements

I am assuming you already have R and RStudio installed on your machine, if you don't go to these links and:
* [Download and Install RStudio](https://www.rstudio.com/products/rstudio/download/#download)
* [Download and Install R](https://cran.r-project.org/)

That's it, you can proceed now.

### Your First R Script
By now you should have RStudio up and running.
First we want to create a new R script, this is where all of our code will live. 
You should get a habit of writing your code inside of R scripts because it can be saved and rerun.

To create a new R script go under File >> New File >> R Script, or you can press ctrl + shift + n. 

New window will appear where you can write your code.

On your first line type:

```r
print('This is an R script!')
```
Now press ctrl + s to save your script, name it whatever you like.
Now you can run your script by pressing source button, this will just print the message you supplied inside the parenthesis. 

Run your first R script: ![](script1.gif) 

It's important to note that R will go trough the script line by line executing them in descending order.

### Installing R Packages
R package is simply a bundle of functions that have a similar purpose.
In our case we will install package called **googleAnalyticsR**. 
To install it type in the following inside your R console and press enter.

```r
install.packages('googleAnalyticsR')
```

Install googleAnalyticsR: ![](install.gif)

Now that you have installed the package you need to load it in order to use all the useful functions found within.

To do so, simply run this line.


```r
library('googleAnalyticsR')
```

Using these two lines of code you can install and load in most of the R packages.

 **googleAnalyticsR** package is developed and maintained by Mark Edmondson, this guy is a rock star, so go follow [him](https://code.markedmondson.me/).

For detailed documentation of googleAnalyticsR see [this](https://code.markedmondson.me/googleAnalyticsR/).

### Making an GA API call from R
To make a call to GA API from R we will use [google_analytics()](https://code.markedmondson.me/googleAnalyticsR/reference/google_analytics.html) function from the package we just installed, but before we do that we have to authenticate first.

You can do that by calling ga_auth() function and following the steps in the console.

Copy this code to your R script, run it from the source, and you should be making your first GA API call from R!

```r
## Load the library
library(googleAnalyticsR)

## Authenticate
ga_auth()

## Make a GA API Call
ga_data <- google_analytics(
  viewId = 211685946,
  date_range = c(Sys.Date()-7, Sys.Date()),
  dimensions = 'date',
  metrics = 'users',
  anti_sample = T
)
```

GA API Call From R: ![](first_call_r.gif)

### What Just Happened?

Let's walk trough this code together line by line.


## Notes on Authentication
The authentication method we used in this tutorial is very basic and limiting, in the next post I will show you how you can create your own GCP project and use it to authenticate your calls to the GA API.

Stay tuned for that, and if you have any questions or suggestions leave them down bellow.

Thanks for reading!
