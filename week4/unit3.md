# Hands-on exercise for week 4 unit 3:<br/>Adapting the UI as a developer – basic extensions

## Previous exercise
[Hands-on exercise for week 4 unit 2:
Adapting an app as a key user](unit2.md)

## Video on openSAP.com platform
[Adapting the UI as a developer – basic extensions](https://open.sap.com/courses/fiori-ea1/items/7yircFcLBZcShIWg8vDtZ8)


## Introduction

In the following two units you will learn how to adapt an application as developer. You will add your own changes to
example standard SAP application according to requirements from your business unit. You have received the following two
screenshots containing the desired changes.

![Trial Home > Home - SAP BTP Cockpit - [InPrivate] - Microsoft​ Edge](images/unit3/req1.png "Trial Home > Home - SAP BTP Cockpit - [InPrivate] - Microsoft​ Edge")

![Trial Home > Home - SAP BTP Cockpit - [InPrivate] - Microsoft​ Edge](images/unit3/req2.png "Trial Home > Home - SAP BTP Cockpit - [InPrivate] - Microsoft​ Edge")

This is the summarized list for you, the developer, with the changes to implement:

1. Remove the options button
2. Change the column title from Category to Type
3. Enlarge the product image in the single object view.
4. Add additional button called Share by Email, which should be able to generate email containing info about products
   that have been selected by the end-user from the table.

In this unit you will learn how to do the first three changes, which are basic UI changes. In the next unit you will
learn how to do the fourth change, which is advanced extension.

### Step 1: Create and launch devspace using SAP Business Application Studio

1. Open your trial account home page at https://cockpit.hanatrial.ondemand.com/ .

   Click  **SAP Business Application Studio** .

   ![Trial Home > Home - SAP BTP Cockpit - [InPrivate] - Microsoft​ Edge](images/unit3/img_0.png "Trial Home > Home - SAP BTP Cockpit - [InPrivate] - Microsoft​ Edge")


2. You will need to created dev space. Click  **Create Dev Space** .

   ![Dev Space Manager - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_000.png "Dev Space Manager - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


3. Enter  **demospace**  in the  **Dev Space name**  box.

   Click  **Create Dev Space** .

   ![Dev Space Manager - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_001.png "Dev Space Manager - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


4. Wait some moment for your just created devspace\`s status to become  **RUNNING** and then click  **demospace** to
   launch it.

   ![Dev Space Manager - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_002.png "Dev Space Manager - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

### Step 2. Create your own Adaptation Project

1. You might or might not be presented with opened preview release notes window if you haven't use this devspace before,
   but, if so, you can close that and proceed on the  **Welcome**  page. Click  **Start from template** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_003.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


2. Click on  **Adaptation Project** to select it.

   Click  **Start** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_004.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


3. Select  **ABAP** from the dropdown list.

   Click  **Next** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_005.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


4. Enter  **my.manage.products**  in the Project Name box.

   Enter  **my app**  in the Application Title box.

   Click  **Next** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_006.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


5. Select  **ES5** from the dropdown list.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_007.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


6. Select  **nw.epm.refapps.st.prod.manage.new**  from the dropdown list. You can type part of the name to filter the
   values in the dropdown list.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_008.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


7. Select  **1.84.13**  from the dropdown list.

   Click  **Finish**. This will trigger the generation of new Adaptation Project which will be your own variant of the
   chosen application.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_009.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

### Step 3: Launch the SAPUI5 Visual Editor for the newly created Adaptation Project

1. After the generation of the project has finished, the whole page might refresh itself to set the current workspace
   SAP Business application studio to the one of the newly created project. After the browser loads successfully, expand
   the webapp folder and right\-click  **manifest.appdescr\_variant**  file.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_010.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


2. Select  **Open SAPUI5 Visual Editor** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_011.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


3. Enter your username and password for ES5 (not the credentials for SAP BTP) in the box.

   Click  **Sign in** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_012.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


4. The editor will need a moment to load, but when it loads, click  **Go** to load the products for that application. As
   you see, the application is in full working order.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_013.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


5. You now see the loaded products for this application. Have in mind that for this application, the SAPUI5 Visual
   Editor is showing placeholders for the product images. Click  **Edit** to go to Edit mode.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_014.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


6. Right\-click on the options button will open a context menu.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_015.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


7. Click  **Remove**.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_016.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


8. Click  **Category**.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_017.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


9. Enter  **Type**  in the field called  **Text**. To find it easier, you can filter the properties list with entering
   the name of the field in the search bar.

   Confirm your entry by pressing the  **Enter key** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_018.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


10. Click  **Preview** to go back to preview mode and to be able to navigate to the app's single object view.
    
     ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_019.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


11. Click the product placed at the top of the table to enter the single object view.
    
     ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_020.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


12. Click  **Edit** to go back to Edit mode.
    
     ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_021.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


13. Click the image placeholder for the product to select it.
    
     ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_022.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


14. Find the dropdown list called  **Display Size**  and Select  **XL** from it. To find it easier, you can filter the
    properties list with entering the name of the field in the search bar.
    
     ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_023.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


15. Click  **Preview** to see the changes that you just did in your application variant, applied over the original
    application.
    
     ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_024.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


16. Click  **Edit** to go back to Edit mode.
    
     ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_025.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


17. Click  **Changes** .
    
     ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_026.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")


18. Here you can see all the changes you have done, with details about them and buttons for deletion if you want to
    revert some of it for example.
    
     ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit3/img_027.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

## Summary

You have completed the exercise!
In this unit, you have learned how to do basic extension over SAP Standard application and preview the changes that you
have done.

## Next Exercise

[Week 4 Unit 4: Adapting the UI as a developer – advanced extensions](unit4.md)
