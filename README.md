# Weather
Weather test

The app should behave as expected. 
I didn’t use any external library. 
All the notifications to the user are done with Alert Views rather. 
The wording of the alerts is for indicative purpose only. 

What I would do with more time:

To cache the Weather report I used FileManager, but after working fine it started acting buggy, so I saved under User Defaults instead, which is not ideal. 
I wouldn’t use the Core Data persistency for this, nor anything as big as Realm. I’d probably use a lightweight third party library. 
When the user is offline and I am presenting the saved data, the weather icon isn’t showing because it downloaded by the imageView. 
I’d probably save the image as data in the model to be able to display it when offline.  
The testing covers mainly the Model and view model, I’d probably test the services more deeply. 
