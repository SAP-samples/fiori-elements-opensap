# Hands-on exercise for week 4 unit 2:<br/>Adapting an app as a key user

## Previous exercise
[Hands-on exercise for week 4 unit 1:
Understanding SAPUI5 flexibility](unit1.md)

## Video on openSAP.com platform
[Adapting an app as a key user](https://open.sap.com/courses/fiori-ea1/items/6Nyx2XSAg9673NrBVe7YYZ)


## Introduction
In this unit, you will learn how to adapt an application as a key user. You will take an example application as delivered by SAP, and make changes according to end user requirements.

These change requirements were collected in a workshop with the end users, they are documented in the two screenshots below:

![targetImage1](images/unit2/Exercises1_stamp.png)
![targetImage2](images/unit2/Exercises2_stamp.png)

The workshop participants also emphasized that they would like to include a currency converter in the application, to display the product prices in Euro.

To summarize, they want you, the key user, to make the following changes to the application:
1)	Remove the "Availability" header element
2)	Remove the sections "Sales Data" and "Notes", as they are not relevant for your users
3)	Rename the "Inventory Information" section to "Inventory" for brevity
4)	Reviews are more important to your users than technical information, hence "Reviews" should be shown first
5)	The "Technical Data" section should show a new field, "Supplier"
6)	The "Base Unit" field should be removed from the "Technical Data" section
7)	Add "Quantity" to the table contained in "Inventory" and put it to the left of "Ordered Quantity"
8)	Add an Iframe as a section to include the CurrencyConverter located at https://themoneyconverter.com/MoneyConverter?from=USD&amp;to=EUR&amp;amount=XXX where XXX is to be replaced by the product’s price. The Iframe should be 180 pixels wide and 220 pixels in height. Name the new section "Price (EUR)" and move it to the first position.


## Step 1. Open the application and start adaptation mode

1. Open the application to be adapted [here](https://sapes5.sapdevcenter.com/sap/bc/ui5_ui5/sap/zdemo_rta_fe/test/index.html?sap-client=002#masterDetail-display). If prompted for a username and password, enter the credentials of the account created during the [last exercise](unit1.md), then click **Sign In**.

	![](images/unit2/img_000.png)

2. Trigger the search in the List Report.

	Click **Go**. <!-- ![](images/unit2/fieldicon00.png). -->

	![](images/unit2/img_002.png)

3. When the list of products is being loaded, select one of the entries to view its detail page.

	![](images/unit2/img_003.png)

4. Start the UI adaptation via the user profile.

	Click **DU**. <!-- ![](images/unit2/fieldicon02.png). -->

	![](images/unit2/img_004.png)

	Click **Adapt UI**. <!-- ![](images/unit2/fieldicon03.png). -->

	![](images/unit2/img_005.png)

## Step 2. Adapt the UI by making key user changes

1. Remove the "Availability" header element

	Right\-clicking on the header element titled "Availability" <!-- ![](images/unit2/fieldicon04.png) --> with the mouse opens a context menu.

	![](images/unit2/img_006.png)

	Click **Remove**. <!-- ![](images/unit2/fieldicon05.png). -->

	![](images/unit2/img_007.png)

2. Remove the "Notes" section.

	Right\-clicking on **Notes** <!-- ![](images/unit2/fieldicon06.png) --> with the mouse opens a context menu.

	![](images/unit2/img_008.png)

	Click **Remove**. <!-- ![](images/unit2/fieldicon07.png). -->

	![](images/unit2/img_009.png)

3. Remove the "Sales Data" section.

	Scroll up to bring the screen to the desired location if the bar containing the section titles is not visible.

	Right\-clicking on **Sales Data** <!-- ![](images/unit2/fieldicon08.png) --> with the mouse opens a context menu.

	![](images/unit2/img_010.png)

	Click **Remove**. <!-- ![](images/unit2/fieldicon09.png). -->

	![](images/unit2/img_011.png)

4. Rename the "Inventory Information" section to "Inventory".

	Scroll up to bring the screen to the desired location if the bar containing the section titles is not visible.

	Right\-clicking on **Inventory Information**  <!-- ![](images/unit2/fieldicon10.png) --> with the mouse opens a context menu.

	![](images/unit2/img_012.png)

	Click **Rename**. <!--  ![](images/unit2/fieldicon11.png). -->

	![](images/unit2/img_013.png)

	Enter the new section title ("Inventory") and confirm by pressing \<Enter\>.

	![](images/unit2/img_014.png)

5. Change the places for the "Technical Data" and "Reviews" sections.

	Drag the "Technical Data" section by clicking on its title with the left mouse button, then holding and dragging it to the right.

	![](images/unit2/img_015.png)

	Once "Reviews" and "Technical Data" have switched places, release the mouse button to confirm the order of sections.

	![](images/unit2/img_016.png)

6. Remove the "Base Unit" field from the "Technical Data" section.

	Right\-clicking on **Base Unit** <!--![](images/unit2/fieldicon16.png)--> with the mouse opens a context menu.

	![](images/unit2/img_017.png)

	Click **Remove**. <!--![](images/unit2/fieldicon17.png).-->

	![](images/unit2/img_018.png)

7. Add the "Supplier" field to the "Technical Data" section

	Right\-clicking on **Weight** <!--![](images/unit2/fieldicon16.png)--> with the mouse opens a context menu.

	<!--In the resulting popup, click  ![](images/unit2/fieldicon18.png).-->

	![](images/unit2/img_019.png)

	Click **Add: Field**.

	![](images/unit2/img_020.png)

    Select **Supplier**, then confirm your selection by clicking "OK".  <!--![](images/unit2/fieldicon19.png).-->

	![](images/unit2/img_021.png)

	The "Supplier" field is now visible in the "Technical Data" section:

	![](images/unit2/img_023.png)

8. Add the "Quantity" column to the "Stock Data" table, and move it to the correct position.

	<!--Select  ![](images/unit2/fieldicon20.png).-->

	Right\-clicking anywhere in the **Stock Data** table <!--![](images/unit2/fieldicon16.png)--> with the mouse opens a context menu.

	![](images/unit2/img_024.png)

	Click **Add: Column**.

	![](images/unit2/img_025.png)

	Select **Quantity**.

	![](images/unit2/img_026.png)

	Click **OK**.

	![](images/unit2/img_027.png)

	The "Quantity" column is now visible. Drag it by clicking on its title with the left mouse button, then holding and dragging it to the left of the "Ordered Quantity" column.

	![](images/unit2/img_028.png)

	![](images/unit2/img_029.png)
## Step 3. Add the CurrencyConverter via an Iframe

1. Open the dialog to define the embedded content.

	Right\-clicking anywhere in the unused area in the header with the mouse opens a context menu. Scroll up, if the header is not visible.

	![](images/unit2/img_030.png)

	Click **Embed Content to: Section**.

	![](images/unit2/img_031.png)

	<!-- Right\-clicking on  ![](images/unit2/fieldicon28.png) with the mouse opens a context menu. -->

	<!-- Drag  ![](images/unit2/fieldicon30.png). -->

2. In the "Define Embedded Content" dialog, make the following settings:

	Set the "Width" to 180 px, and the "Height" to 220 px.

	![](images/unit2/img_042.png)

3. Specify the URL for the external content.

	Paste the following URL in the "URL (click to edit manually)" field: https://themoneyconverter.com/MoneyConverter?from=USD&amp;to=EUR&amp;amount=

	![](images/unit2/img_044.png)

	In the "Available Values (click to add to the URL)" list, scroll down until the "Price" entry is visible.

	Click **Price**.

	![](images/unit2/img_045.png)

	Ensure, that the URL entered in the text area on the right now ends in "{Price}" (without quotes).

4. Confirm your settings by displaying the preview of the embedded content.

	Click **Show Preview**.

	![](images/unit2/img_049.png)

	A preview of the currency converter, including the correct price for the currently selected product, should be displayed below.

	Click **Save**.  <!--![](images/unit2/fieldicon41.png).-->

	![](images/unit2/img_050.png)

	Rename the new section ("Embedded Content") to "Price (EUR)".

	![](images/unit2/img_051.png)

## Step 4. Save your changes
Click **Save & Exit**. <!--![](images/unit2/fieldicon42.png).-->

![](images/unit2/img_052.png)

Reload your current browser tab:

Right\-clicking anywhere in the application with the mouse opens a context menu.

![](images/unit2/img_053.png)

Click **Reload**. <!--![](images/unit2/fieldicon44.png).-->

![](images/unit2/img_054.png)

The application now reflects the changes you have made during this exercise.

![](images/unit2/img_055.png)
## Summary
You have completed the exercise!
In this unit, you have learned how the key user can make changes to an application. You have seen several types of changes, e.g. setting the visibility for individual fields, changing the order of sections, adding columns and fields, and even embedding third-party content into your application.
The next step would be to make these changes available to your end users. Depending on the platform you're working, the exact procedure might differ.

## Next Exercise
[Week 4 Unit 3: Adapting the UI as a developer – basic extensions](unit3.md)
