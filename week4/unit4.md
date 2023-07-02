# Hands-on exercise for week 4 unit 4:<br/>Adapting the UI as a developer – advanced extensions

## Previous exercise
[Hands-on exercise for week 4 unit 3:
Adapting the UI as a developer – basic extensions](unit3.md)

## Video on openSAP.com platform
[Adapting the UI as a developer – advanced extensions](https://open.sap.com/courses/fiori-ea1/items/3B0Sebyq42o6sHlpGCqI9B)


## Introduction 
In this exercise you will learn how to do advanced extensions to your application variant. You should use the project that you have already created in the previous exercise.

## Step 1: Create the XML fragment that will describe you custom UI element.

1. Start with loading the project from the previous exercise in SAP Business Application Studio. Launch the SAPUI5
   Visual Editor for it and while in Preview mode load the data by clicking the **Go** button. Then switch to **Edit**
   mode. Open the context menu for the table header by right-click on it.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_0.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

2. Click  **Add Fragment** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_000.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

3. Select  **5**  from the dropdown list, which will set the desired index for your UI element. This way you can
   specifically match the requirements for the position of the button (as shown on the drawing in the beginning of the
   previous unit).

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_001.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

4. Click  **Create New** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_002.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

5. Enter  **shareButtonFragment**  in the box.

   Click  **Create** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_003.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

6. You should now replace the full content of that file with the following code.

   ```xml
   <!-- Use stable and unique id's!-->
   <core:FragmentDefinition xmlns:core='sap.ui.core' xmlns='sap.m'>
       <Button id='btnShareByEmail' text='Share by Email' press='.extension.my.manage.products.mycontroller.onShareClick'>
       </Button>
   </core:FragmentDefinition>
   ```

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_004.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

7. You can now close the fragment xml file. Click  **X**  to its filename

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_005.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

### Step 2: Create your own custom controller extension

1. You are now again looking at the SAPUI5 Visual Editor. Open the context menu for the table header by right-click on
   it.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_006.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

2. Click  **Extend with Controller** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_007.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

3. Enter  **mycontroller** in the text field.

   Click  **Extend** .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_008.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

4. If you open coding file for first time for this devspace you will be asked for ESlint checks. If so, click  **Close**
   .

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_009.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

5. You should now put the following code inside the controllers functions. It should be placed **after** line 14 of the
   generated file that you see.

   ```javascript
   onShareClick: function (oEvent) {
       var oExtensionApi = this.base.templateBaseExtension.getExtensionAPI();
       var aSelection = oExtensionApi.getSelectedContexts();
       if (aSelection.length > 0) {
           var sTo = "nobody@sap.com";
           var sSubject = "Look at these products"
           var sProducts = aSelection.reduce(function (sText, oSelectedContext) {
               var mSelectedData = oSelectedContext.getObject();
               return sText + mSelectedData.Product + " | " + mSelectedData.Price + " | " + mSelectedData.Currency + "\n";
           }, "");
   
           sap.m.URLHelper.triggerEmail(sTo, sSubject, sProducts);
       }
   }
   ```

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_010.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

6. Now you can close the controller file by clicking  **X**  next to its filename.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_011.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

### Step 3: Preview the business logic you just created and added

1. As you see, SAPUI5 Visual Editor detects that changes have been made outside of it and asks you to reload it. Close
   it by clicking the  **X**  button of this tab.

   ![demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge](images/unit4/img_012.png "demospace - SAP Business Application Studio and 1 more page - [InPrivate] - Microsoft​ Edge")

2. Right-click on the  **manifest.appdescr\_variant**  file from the file explorer to bring its context menu and
   choose  **Open SAPUI5 Visual Editor**  to launch it again.

   ![demospace - SAP Business Application Studio - [InPrivate] - Microsoft​ Edge](images/unit4/img_013.png "demospace - SAP Business Application Studio - [InPrivate] - Microsoft​ Edge")

3. You can see your new custom button there. Click  **Go** , to load the application's data.

   ![demospace - SAP Business Application Studio - [InPrivate] - Microsoft​ Edge](images/unit4/img_014.png "demospace - SAP Business Application Studio - [InPrivate] - Microsoft​ Edge")

4. Check both the checkboxes

   ![demospace - SAP Business Application Studio - [InPrivate] - Microsoft​ Edge](images/unit4/img_015.png "demospace - SAP Business Application Studio - [InPrivate] - Microsoft​ Edge")

5. Click  **Share by Email** .

   ![demospace - SAP Business Application Studio - [InPrivate] - Microsoft​ Edge](images/unit4/img_016.png "demospace - SAP Business Application Studio - [InPrivate] - Microsoft​ Edge")

6. The default system email client will open and will show you the generated email filled with data about the two
   products that you just selected.

   ![Look at these products - Message (HTML) ](images/unit4/img_017.png "Look at these products - Message (HTML) ")

## Summary

You have completed the exercise!
In this unit, you have learned how to create advanced extension to SAP delivered application in SAP Business Application
Studio with SAPUI5 Adaptation project, using SAPUI5 Visual Editor.
