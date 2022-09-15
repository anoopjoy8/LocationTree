<cfset task2       = createObject("component","Locationtree/cfc/task2")/>
<cfset child_ids  = task2.getChilds(loc_id=3) />
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title>Location Tree</title>
        <link href="dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <cfoutput>
            <main class="container">
                <h1 class="text-center mt-3">Task5</h1>
            </main>
         #child_ids#
        </cfoutput>
    </body>
</html>