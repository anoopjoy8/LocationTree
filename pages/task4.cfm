<cfset task2       = createObject("component","Locationtree/cfc/task2")/>
<cfset parent_ids  = task2.getParents(loc_id=5) />
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
                <h1 class="text-center mt-3">Task4</h1>
            </main>
            #parent_ids#
        </cfoutput>
    </body>
</html>