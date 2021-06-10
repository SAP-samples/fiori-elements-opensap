# Hands-on exercise for week 1 unit 4:<br/>Preparing your ABAP development environment

## Video on openSAP.com platform
[Preparing your ABAP development environment](https://open.sap.com/courses/fiori-ea1/items/2s7GNtSh3Sg8EvYKirNMeU)

## Introduction
In this unit you will set up your development environment that you need for the next units. 

In the first step you will create a trial account on SAP Business Technology Platform (SAP BTP). Please mind, that the trial environment is for educational purposes only, not for productive usage. Also, the lifetime is limited.

After that, the ABAP environment on SAP BTP needs to be set up. We use SAP BTP as it’s very easy to get an ABAP environment. Also, you are always working on the latest version of ABAP platform which gives you access to the latest features and improvements.

Last step in this unit is to install ABAP Development Tools which then gets connected to the ABAP environment on SAP BTP.

**For the exercises of weeks 1-3 this is a prerequisite.**

## Step 1. Get a free trial account on SAP Business Technology Platform
You need a free trial account for the SAP Business Technology Platform to do the exercises.

**Your account needs to be assigned to either Europe or US East. Singapore is currently not supporting the ABAP environment on SAP BTP.**

**If you already have an SAP BTP Trial account you can continue with step 2.**

1. Open the following link in your browser: **https://www.sap.com/products/business-technology-platform/trial.html**
    
   ![](images/unit4/prepare-btp-1.png)


2. Click on the button **Start your free trial** in order to open the dialog to register.
   
    ![](images/unit4/prepare-btp-2.png)


3. Follow the instructions to create your free trial account.
   
    ![](images/unit4/prepare-btp-3.png)


4. Once your trial account is ready get back to the SAP BTP Trial homepage and click on **Log in to the trial**.
   
    ![](images/unit4/prepare-btp-4.png)
   

5. On the welcome page you can enter the SAP BTP Cockpit by clicking on the button **Enter Your Trial Account**.
   
    ![](images/unit4/prepare-btp-5.png)



## Step 2. Set up the ABAP Environment on  SAP Business Technology Platform
The ABAP environment we will use is running in SAP Business Technology Platform.
<br>**If you have already set up the ABAP Environment on  SAP Business Technology Platform before you can skip this step.**

1. Open the SAP BTP Cockpit and click on **Boosters** in the navigation menu on the left.
   
    ![](images/unit4/prepare-btp-6.png)


2. On the tile **Prepare an Account for ABAP Trial** click on the **Start** button. This will take a short amount of time.
    
    ![](images/unit4/prepare-btp-7.png)


3. If you get asked for a subaccount select **trial** in the dropdown **Subaccount**. The fields **Org** and **Space** will automatically be populated by the system. <br>Then click **Finish**.
    
    ![](images/unit4/prepare-btp-9.png)


4. Once the provisioning is completed a dialog will open. Click on **Download Service Key**. You will need it in step 3. 
    
    ![](images/unit4/prepare-btp-8.png)
   

## Step 3. Install ABAP Development tools
In order to work with ABAP environment on SAP BTP you need to download and install ABAP Development Tools.
<!--Follow the instructions [SAP Development Tools](https://tools.hana.ondemand.com/#abap)-->

1. Open https://tools.hana.ondemand.com/#abap. You need to verify, that your machine fulfills the prerequisites:
   - Java Runtime 
   - Fow Windows OS: Microsoft VC Runtime
    
    ![](images/unit4/prepare-adt-1.png)


2. Scroll down to **Procedure** and perform the first step: Get an installation of Eclipse. 
   Download and install it. <br>Ideally, you also copy the URL from step 3. into your clipboard.
    
    ![](images/unit4/prepare-adt-2.png)


3. Open Eclipse. Then click on **Help** -> **Install New Software...**

    ![](images/unit4/prepare-adt-3.png)


4. Enter a Name, e.g. **ADT**. The Location needs to be **https://tools.hana.ondemand.com/latest**.
    <br>Then click on **Add**.

    ![](images/unit4/prepare-adt-4.png)


5. Check the checkbox at **ABAP Development Tools**. Then click **Next**.

    ![](images/unit4/prepare-adt-5.png)


6. In the Install Details screen click on **Next**.
    
    ![](images/unit4/prepare-adt-6.png)


7. Accept the license agreements. Then click **Finish**.

    ![](images/unit4/prepare-adt-7.png)


8. In the dialog for the Certificates click on **Select All**. Then click on **Accept selected**.

    ![](images/unit4/prepare-adt-8.png)


9. Once the installation is completed you need to restart Eclipse. Click on **Restart Now**.

    ![](images/unit4/prepare-adt-9.png)


10. To switch to the ABAP perspective click on **Window** -> **Perspective** -> **Other...**.

    ![](images/unit4/prepare-adt-10.png)


11. Select **ABAP**. Then click **Open**.

    ![](images/unit4/prepare-adt-11.png)


12. To connect to the ABAP environment on SAP BTP click on **Create an ABAP cloud project**.

    ![](images/unit4/prepare-adt-12.png)


13. Select **Service Key**. Then click **Next >**. 

    ![](images/unit4/prepare-adt-13.png)


14. Click on the button **Import...** below the textarea. Select the service key which you downloaded in the previous step. 
    Then click **Next >**.

    ![](images/unit4/prepare-adt-15.png)


15. Now you need to log on to the SAP cloud system. Click on **Open Logon Page in Browser**. 
    If you are still logged on with your SAP BTP Trial user you will automatically be redirected to the success page. 
    If you get prompted for a user and password enter your SAP BTP Trial credentials.

    ![](images/unit4/prepare-adt-16.png)


16. When the logon was successful you will see the following page, and you can go back to Eclipse.

    ![](images/unit4/prepare-adt-17.png)


17. In the Service Instance Connection screen you can click **Next >**.

    ![](images/unit4/prepare-adt-18.png)


18. In the Project Name and Favorite Packages screen click on **Finish**.

    ![](images/unit4/prepare-adt-19.png)


19. The ABAP environment on SAP BTP is now connected to ABAP Development Tools.
    
    ![](images/unit4/prepare-adt-20.png)


## Summary
You have completed the exercise!
In this unit, you have learned 
- How to set up your ABAP development environment for this course

## Next Exercise
[Week 1 Unit 5: Creating an OData service with ABAP RESTful Application Programming Model](unit5.md)
