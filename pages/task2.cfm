<cfset task2      = createObject("component","Locationtree/cfc/task2")/>
<cfset Depthvalue = task2.getDepth(loc_id=5) />
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
                <h1 class="text-center mt-3">Task2</h1>
            </main>
            #Depthvalue.depth#
        </cfoutput>
    </body>
</html>