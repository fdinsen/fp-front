# fp-front

<p>This elm project is a front end to the back end found at https://github.com/fdinsen/FP-backend-java .</p>
<p>It is a system that adds books with authors to users, and then gets a list of all books on a given user. </p>


<br>
<p>The model is a Tuple that holds two sub-models, one for the "add book" module and one for the "get books" module. </p>
<p>The system uses Elm-Bootstrap-5.2.0 to format the view.</p>
<p>Both modules are visible at once and are updated independent of eachother.</p>

<br>
<p>As mentioned above, Model is a Tuple of AddModel and GetModel, each containing the state of their own respective side of the application.</p>
<br> 
<p>An interesting problem I ran into was that since I had a Model which constists of two sub-models, I at first had a massive 'case of', which went through every combination of AddModel and GetModel possible (can be seen commented out in Main.elm.) This was a terrible solution, because it repeated the same lines of code for each possible combination, which is unmaintainable as the applicaiton grows.</p>
<p>My solution was to break each sub-model out into their own functions for determining which HTML module to display. Each of these two functions has a 'case of' for handling its own Model. This way, if getModel was to grow to include more possible states, I would only have to add that case in one place, instead of having to add it once for every possible state addModel could possibly be in.</p>

<br><br>
<p>HTMLModules contains some functions for composing the visual side of the application:</p>
<ul>
  <li>grid: composes the side-by-side view of the application</li>
  <li>card: creates the outline of each module</li>
</ul>
<p>Each of the two sub-models have their visual side separated into their own Modules.</p>
<p>Add:</p>
<ul>
  <li>addBook: displays the form</li>
  <li>addBookForm: contains the form itself</li>
  <li>loadingBok: displays the form as well as a loading animation</li>
  <li>addSuccess: displays the form as well as the success message received from the backend</li>
  <li>addError: displays the form as well as any error found. The error is converted to a string in errorToString in ApiFacade</li>
</ul>
<p>Get:</p>
<ul>
  <li>getBooks: displays the form</li>
  <li>getBooksForm: contains the form itself</li>
  <li>showBooks: displays the form as well as the table containing the result. This table is mapped with showBook</li>
  <li>showBook: takes a book and turns it into a table row</li>
  <li>loadingUser: displays the form as well as a loading animation</li>
  <li>getError: displays the form as well as any error found. The error is converted to a string in errorToString in ApiFacade</li>
</ul>
