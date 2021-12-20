# Hands-on exercise for week 3 unit 4:<br/>Deploying your SAP Fiori elements app

## Previous exercise
[Creating an overview page](unit3.md)

## Video on openSAP.com platform
[Deploying your SAP Fiori elements app](https://open.sap.com/courses/fiori-ea1/items/6yMBBtyC3H9xnapEHVCIqw)
## Introduction

**Prerequisite: You have performed all previous exercises of this course.**

In this unit, you will learn how to deploy the application that have been previously built to our **SAP cloud account** and run them together in the **SAP Fiori launchpad**.

Before we start adding the configurations, we make sure a terminal is open and we are logged into our cloud account.

## Step 1. Open terminal and log into cloud account
1. Click in menu `Terminal` -> `New Terminal` 

    ![](images/unit4/A_img_0.png)

1. This will open a new terminal. Next we make sure that we are logged into our cloud account by executing the following command ...<br>
   ... for BTP trial region 🇪🇺 Europe:
    ```
    cf login -a https://api.cf.eu10.hana.ondemand.com
    ```
   ... for BTP trial region 🇺🇸 US:
    ```
    cf login -a https://api.cf.us10.hana.ondemand.com
    ```
    ![](images/unit4/A_img_000.png)

1. We need to provide the email address that we used when we signed up for the cloud account ...

    ![](images/unit4/A_img_001.png)

1. ... and also the password.

    ![](images/unit4/A_img_002.png)


Before we deploy our applications, we add deploy and SAP Fiori launchpad configurations to each of our SAP Fiori elements applications `bookinganalysis`, `travellist`, and `traveloverview`.

## Step 2. Add deploy config to bookinganalysis

1. In the terminal change to folder `bookinganalysis` by executing command

    ```
    cd bookinganalysis
    ```

    ![](images/unit4/A_img_004.png)

1. Start the interactive deployment config generator by executing command

    ```
    npx fiori add deploy-config
    ```
    ![](images/unit4/A_img_005.png)

1. The fist prompt is `Please choose the target`. Use the arrow up/down keys to select `Cloud Foundry ` and hit enter.

    ![](images/unit4/A_img_006.png)

1. Next it asks for a `Destination name`. Keep the selected entry `abap-cloud-default_abap-trial(SCP)` and hit enter.

    ![](images/unit4/A_img_007.png)

1. Answer the question `Add application to managed application router?` with `Y` for yes. Hit again the enter key.

    ![](images/unit4/A_img_008.png)

The deploy configuration will now be generated.


## Step 3. Add SAP Fiori launchpad config to bookinganalysis

1. In the terminal in same folder execute following command to add a SAP Fiori launchpad configuration:

    ```
    npx fiori add flp-config
    ```

    This will start the interactive generator to add a SAP Fiori launchpad configuration.

    ![](images/unit4/A_img_009.png)

1. For `Semantic Object` enter the value `Booking`.

    ![](images/unit4/A_img_010.png)

1. For `Action` enter the value `analysis`.

   ![](images/unit4/A_img_011.png)

1. The `Title` can be freely set, we use `Booking Analysis`.

   ![](images/unit4/A_img_012.png)

1. We can skip the `Subtitle (optional)` by just hitting enter. This concludes the creation of the SAP Fiori launchpad.

Now we have added a deploy and SAP Fiori launchpad configuration and can continue to build and deploy the application `bookinganalysis`.


## Step 4. Build and deploy the application bookinganalysis

Now that we have the deploy and SAP Fiori launchpad configurations, we can build and deploy the application. 

1. The artifact that is deployed to Cloud Foundry is call a Multi Target Application (MTA). To build this, we can execute following command in the terminal:

    ```
    npm run build:mta
    ```

    ![](images/unit4/A_img_014.png)


1. This will build the file `bookinganalysis/mta_archives/archive.mtar`. Now we can start the deployment using command

    ```
    npm run deploy
    ```

    ![](images/unit4/A_img_015.png)

This will upload the mta we have build to the cloud account.


Because we want to deploy all 3 applications, we need to repeat these steps for application `travellist` and `traveloverview`.

## Step 5. Add deploy config to travellist

1. In the terminal, change to the folder ../travellist by executing command

    ```
    cd ../travellist
    ```

    ![](images/unit4/A_img_016.png)


1. Now add the deploy config by executing command

    ```
    npx fiori add deploy-config
    ```

1. Use the same values as we did for the application we configured previously:

    ```
    Please choose the target: Cloud Foundry
    Destination name: abap-cloud-default_abap-trial(SCP)
    Add application to managed application router?: Yes
    ```

    ![](images/unit4/A_img_017.png)

## Step 6. Add SAP Fiori launchpad config to travellist

1. We add also a SAP Fiori launchpad configuration to the `travellist` application by executing command 

    ```
    npx fiori add flp-config
    ```

1. For the `travellist` application we use following values below. The subtitle can be set, but here we leave it empty. 

    ```
    Semantic Object: Travel
    Action: manage
    Title Travel: List
    Subtitle: (optional) 
    ```

    ![](images/unit4/A_img_019.png)


## Step 7. Build and deploy the application travellist

1. As for the previous application, in order to deploy the `travellist` we need to build the mta first using command

    ```
    npm run build:mta
    ```
    ![](images/unit4/A_img_020.png)    

1. Then we can deploy the application with command

    ```
    npm run deploy
    ```

    ![](images/unit4/A_img_021.png)


## Step 8. Add deploy config to traveloverview

1. We also add a deploy and SAP Fiori launchpad configuration for the `traveloverview` application, but first we change to the folder by executing command:

    ```
    cd ../traveloverview
    ```

    ![](images/unit4/A_img_023.png)    

1. Then we execute again the command to add the deployment configuration

    ```
    npx fiori add deploy-config
    ```

1. And again, we use the same values:

    ```
    Please choose the target: Cloud Foundry
    Destination name: abap-cloud-default_abap-trial(SCP)
    Add application to managed application router?: Yes
    ```

    ![](images/unit4/A_img_024.png)


## Step 9. Add SAP Fiori launchpad config to traveloverview

1. In the same way as for the other applications, we also add a SAP Fiori launchpad configuration to `traveloverview` by running command

    ```
    npx fiori add flp-config
    ```

1. For `traveloverview` we use the values:

    ```
    Semantic Object: Travel
    Action: overview
    Title: Travel Overview
    Subtitle (optional): 
    ```

    ![](images/unit4/A_img_025.png)

## Step 10. Build and deploy the application traveloverview

1. As a last step in this section we build the mta for `traveloverview` and deploy it to our cloud account using the commands ...

    ```
    npm run build:mta
    ```

    ![](images/unit4/A_img_026.png)

1. ... followed by command:

    ```
    npm run deploy
    ```

    ![](images/unit4/A_img_027.png)


## Step 11. Creating a SAP Fiori launchpad and adding the applications

In this part of the exercise we will enable the Launchpad service in your cloud account, create a SAP Fiori launchpad and add the previously deployed applications to it. 

1. Navigate to https://account.hanatrial.ondemand.com and login to your cloud trial account.

    ![](images/unit4/B_img_0.png)

1. Inside the cloud cockpit navigate to your `trial` subaccount.

    ![](images/unit4/B_img_000.png)


## Step 12. Activate the Launchpad service

1. In Cloud Cockpit in your sub account click on `Service Marketplace`.

    ![](images/unit4/B_img_001.png)

1. Search for `launchpad` and click the tile.

    ![](images/unit4/B_img_002.png)

1. Find the `Create` button and click it.

    ![](images/unit4/B_img_003.png)

1. Keep the dropdown list boxes and click on `Create`.

    ![](images/unit4/B_img_004.png)

1. In the confirmation popup click on `Close`.

    ![](images/unit4/B_img_005.png)


## Step 13. Add launchpad role to your user

In order to manage SAP Fiori launchpads, you need to add the launchpad role to your user. 

1. Expand `Security` in the navigation bar on the left and click on `Users`. In the users list click on the row with your user name.

    ![](images/unit4/users1.png)

1. In the section `Role Collections` click on the button with the three dots, then on `Assign Role Collection`.

    ![](images/unit4/users2.png)

1. In the dialog search for `launchpad`, check the checkbox at `Launchpad Admin`, then click on `Assign Role Collection`.

    ![](images/unit4/users3.png)



## Step 14. Create launchpad and add applications

In order to create a new launchpad we need to open the Site Manager. 

1. In the menu of subaccount trial click on `Instances and Subscriptions`.

    ![](images/unit4/B_img_013.png)

1. Find the `Launchpad Service` and click on `Go to Application`.

    ![](images/unit4/B_img_014.png)

    This will open the 'Site Manager'.

1. Click the button `+ Create Site`.

    ![](images/unit4/B_img_015.png)

1. Give the new site a name, for instance `Travel` and click button `Create`.

    ![](images/unit4/B_img_016.png)

1. Click the back arrow to see the site directory.

    ![](images/unit4/B_img_017.png)

1. In the navigation bar on the left click on `Provider Manager`.

    ![](images/unit4/B_img_018.png)

1. Click the `Fetch updated content` button to refresh the HTML5 repository.

    ![](images/unit4/B_img_019.png)

1. In the navigation bar click on `Content Manager`.

    ![](images/unit4/B_img_020.png)

1. Click on tab `Content Explorer`.

    ![](images/unit4/B_img_021.png)

1. Click on tile `HTML5 Apps`.

    ![](images/unit4/B_img_022.png)

1. Select all 3 application and click button `+ Add to MyContent`.

    ![](images/unit4/B_img_023.png)

1. Switch back to `MyContent` tab. 

    ![](images/unit4/B_img_024.png)

1. Click `Everyone`.

    ![](images/unit4/B_img_025.png)

1. Click on `Edit` button.

    ![](images/unit4/B_img_026.png)

1. Set the cursor into field `+ Search for items to assign` and select 3 applications.

    ![](images/unit4/B_img_027.png)

1. Click button `Save`.

    ![](images/unit4/B_img_028.png)

1. Click on `Back to content management`.

    ![](images/unit4/B_img_029.png)

1. Click on `+ New` and select `Catalog`.

    ![](images/unit4/B_img_030.png)

1. Enter for instance `Travel Catalog` as title.

    ![](images/unit4/B_img_031.png)

1.  Set the cursor into field `+ Search for items to assign` and select all 3 applications.

    ![](images/unit4/B_img_032.png)

1. Click `Save` to assign the application to the catalog.

    ![](images/unit4/B_img_033.png)

1. Click on `Back to content management`.

    ![](images/unit4/B_img_034.png)

1. Click on `+ New` and select `Group`.

    ![](images/unit4/B_img_035.png)

1. Enter as title for instance `Travel Apps`.

    ![](images/unit4/B_img_036.png)

1. Set the cursor into field `+ Search for items to assign` and select all 3 applications.

    ![](images/unit4/B_img_037.png)

 1. Click `Save`.

    ![](images/unit4/B_img_038.png)

## Step 5. Test launchpad

1. From the navigation bar select `Site Directory`.

    ![](images/unit4/B_img_039.png)

1. In the Site Directory' view click on `Go to site`.

    ![](images/unit4/B_img_040.png)

    This should open the launchpad showing the 3 applications we have deployed. 

1. You can test the apps and navigation, for instance by clicking on  application `Travel Overview`.

    ![](images/unit4/B_img_041.png)

1. In 'Travel Overview' you can click the chart.

    ![](images/unit4/B_img_042.png)

 1. This will trigger navigation to 'Booking Analysis'. From there you can go back.

    ![](images/unit4/B_img_044.png)

    Which brings you back to the 'Travel Overview'. You can also click an entry in card 'Travel List'.
    
    ![](images/unit4/B_img_045.png)
    
1. This will navigate to 'Travel List' application.

    ![](images/unit4/B_img_046.png)

## Summary
You have completed the exercise!
In this unit, you have learned 
- How to add deploy and SAP Fiori launchpad configurations to applications
- How to deploy SAP Fiori applications
- How to create a SAP Fiori launchpad and add applications to it

## Next Exercise
[Week 3 Unit 5: Building an SAP Fiori elements app with an external OData service](unit5.md)
