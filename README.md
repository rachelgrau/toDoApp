# To-do App
An iOS app that lets users add to-dos to a to-do list. Written in Objective-C. 

<b>TO RUN APP:</b>
- Click on "Clone or download" --> "Download ZIP"
- Open toDoApp-master --> toDoApp.xcodeproj in XCode
- Run on simulator or on your own device (note that if you have an iPhone X, I've noted a couple problems on iPhoneX that I'd like to improve) 

<b>FEATURES:</b>
- Add to-dos (name, description, and priority), edit to-dos, delete to-dos.
- Mark a to-do as complete, see a list of completed to-dos below the outstanding to-dos.
- Mark a to-do as high priority.
- Reorder to-dos. Move to-dos between the oustanding and completed sections.

<b>IMPLEMENTATION:</b>

Important View Controllers
- <b>ToDoListViewController.[h/m]</b>: this class displays a single to-do list. On this screen the user can add to-dos quickly by typing in the textfield at the top. On top is a section of outstanding to-dos, and below that is a section displaying completed to-dos. The user can mark to-dos as complete by clicking on a checkmark. 
- <b>ToDoItemViewController.[h/m.</b>: this class displays a single to-do item and allows the user to edit its name, description, and priority.

Models
- <b>ToDoItem.[h/m]</b>: this class represents a To-do object. It stores the to-do's name, description, priority, and whether it's completed. For now we store a user's to-dos on their phone (not a backend, not Core Data) with NSUserDefaults (temporary hack).

<b>DECISIONS I MADE ALONG THE WAY:</b>
- Hacky fix for data persistence: I'm storing the user's to-dos in NSUserDefaults. This is hacky and not ideal (NSUserDefaults meant to store state, not things like objects). Should use a backend database or Core Data.
- Design: since it's a to-do app, I figure users will be using it to feel organized. So, I focused on making the design look very clean, minimalistic, and organized. I use blue as the action color (associated with stability, trust, cleanliness) and shades of gray everywhere else.
- Design: at first I had the first screen as a to-do list with an add button at the top. The add button took you to a new screen where you'd fill out the title of the to-do, a description, and whether it was high priority (very similar to how the ToDoItemViewController turned out). However, I had a couple friends try the app and found that they just wanted to be able to add to-dos really quickly. So, I changed the design to have a textfield up top on the very first screen that allows users to add to-dos really quickly (and then edit them if they want to add description/priority). 
- I designed all the (very simple) graphics: check mark, priority icon, app icon.
- Some important features I decided to include: marking to-dos as complete or incomplete, setting priority, reordering to-dos.
- I decided to spend the time to programatically set up the ToDoItemViewController instead of using storyboard. This is because I wanted the name textfield and description textfield to adjust based on the height of the name and description, respectively. So, if a name is really long, it will display the entire name on multiple lines. Same for description. I also put everything in a scroll view in case there are long names/descriptions.
- I originally implemented something that made the high priority to-dos automatically go to top of their section, but then I realized it doesn’t make sense when you can ALSO reorder the cells. For example, we automatically push a high priority to-do to the top, but then the user reorders it to the bottom, and next time they mark another to-do as high priority where does it go?  

<b>FUTURE IMPROVEMENTS TO MAKE:</b>
- Use a backend database or Core Data for data persistence.
- Would be nice to be able to reorder the cells without having to click on a reorder button. Reason I haven't had time to do this is because to reorder cells I have to put the tableview in editing mode, which changes the layout of the table view cells.
- If a to-do has a very long name, it's difficult to edit the description because the keyboard covers it. Would like to have the description animate up in this case so that it's easier to edit.
- Would like to make table view cells tall enough to display long to-dos. 
- Would like to display the description of a to-do (if it has one) on the to-do list screen.
- When editing the name or description of a to-do in ToDoItemViewController, I would like the textviews to grow in height as the user types more.
- Unresolved iPhone X issues: weird space between back button and title, also weird space at bottom of save button
- Should limit the length of to do items or descriptions. 
- Didn't implement for iPad
- Add ability to sight to go back on navigation (from ToDoItemViewController to ToDoListViewController)
- Add testing!

<b>FUTURE FEATURES:</b>
- Connect to a backend.
- Allow users to have multiple to-do lists.
- Have a nice animation when you mark a to-do as complete.
- Add dates to “to do” items. 
