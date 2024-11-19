<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Passwords Database Manager</title>
    <link rel="stylesheet" href="css/style.css">
  </head>
  <body>
    <form id="clear-results" method="post"
          action="<?php echo $_SERVER['PHP_SELF']; ?>">
      <input id="clear-results__submit-button" type="submit" value="Clear Results">
    </form>
    <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
      <fieldset>
        <legend>Search</legend>
        <input type="text" name="search" autofocus required>
        <input type="hidden" name="submitted" value="1">
        <p><input type="submit" value="search"></p>
      </fieldset>
    </form>
    <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
      <fieldset>
        <legend>Update</legend>
        UPDATE website SET
        <select name="current-attribute" id="current-attribute">
          <option>website_name</option>
          <option>website_url</option>
        </select>
        = <input type="text" name="new-attribute" required> WHERE
        <select name="query-attribute" id="query-attribute">
          <option>artist_id</option>
          <option>artist_name</option>
        </select>
        = <input type="text" name="pattern" required>
        <input type="hidden" name="submitted" value="2">
        <p><input type="submit" value="update"></p>
      </fieldset>
    </form>
    <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
      <fieldset>
        <legend>Insert</legend>
        INSERT INTO website VALUES ( <input type="text" name="website_name" placeholder="website_name" required>, <input type="text" name="website-url" placeholder="website_url" required>
        <input type="text" name="email" placeholder="email" required>, <input type="text" name="user_name" placeholder="user-name" required>,
        <input type="text" name="password" placeholder="password" required>, <textearea name="comment" placeholder="comment" required>);
        <input type="hidden" name="submitted" value="3">
        <p><input type="submit" value="insert"></p>
      </fieldset>
    </form>
    <form method="post" action="<?php echo $_SERVER['PHP_SELF']; ?>">
      <fieldset>
        <legend>Delete</legend>
        DELETE FROM artist WHERE
        <select name="current-attribute" id="current-attribute">
          <option>artist_id</option>
          <option>artist_name</option>
        </select>
        = <input type="text" name="pattern" required>
          <input type="hidden" name="submitted" value="4">
        <p><input type="submit" value="delete"></p>
      </fieldset>
    </form>


<?php
require_once "includes/config.php";
require_once "includes/helpers.php";

$option = (isset($_POST['submitted']) ? $_POST['submitted'] : null);

if ($option != null) {
    switch ($option) {
        case SEARCH:
            if ("" == $_POST['search']) {
                echo '<div id="error">Search query empty. Please try again.</div>' .
                    "\n";
            } else {
                if (NOTHING_FOUND === (search($_POST['search']))) {
                    echo '<div id="error">Nothing found.</div>' . "\n";
                }
            }

            break;

        case UPDATE:
            if ((0 == $_POST['new-attribute']) && ("" == $_POST['pattern'])) {
                echo '<div id="error">One or both fields were empty, ' .
                    'but both must be filled out. Please try again.</div>' . "\n";
            } else {
                update($_POST['current-attribute'], $_POST['new-attribute'],
                    $_POST['query-attribute'], $_POST['pattern']);
            }

            break;

        case INSERT:
            if (("" == $_POST['website_name']) || ("" == $_POST['website_url']) || ("" == $_POST['email']) || ("" == $_POST['user_name'])
            || ("" == $_POST['password']) ) {
                echo '<div id="error">At least one field in your insert request ' .
                     'is empty. Please try again.</div>' . "\n";
            } else {
                insert($_POST['artist-id'],$_POST['artist-name']);
            }

            break;

        case DELETE:
            if (("" == $_POST['current-attribute']) || ("" == $_POST['pattern'])) {
            echo '<div id="error">At least one field in your delete procedure ' .
                 'is empty. Please try again.</div>' . "\n";
        } else {
            delete($_POST['current-attribute'], $_POST['pattern']);
        }

        break;

    }
}

?>
  </body>
</html>
