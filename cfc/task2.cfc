<cffunction name="getDepth" output="false" access="public">
    <cfargument name="loc_id" type="string" required="false" default="" />
    <cfset var chid = arguments.loc_id/>
    <cfquery name="get_all_parents">
            with recursive parent_users (id, parent_id, level) AS (
            SELECT id, parent_id, 1 level
            FROM location_tree
            WHERE id = #chid#
            union all
            SELECT t.id, t.parent_id, level + 1
            FROM location_tree t INNER JOIN parent_users pu
            ON t.id = pu.parent_id
            )
            SELECT count(level) as depth FROM parent_users;           
    </cfquery>
    <cfreturn get_all_parents />
</cffunction>


<cffunction name="getParents" output="false" access="public">
    <cfargument name="loc_id" type="string" required="false" default="" />
    <cfset var chid = arguments.loc_id/>
    <cfquery name="get_all_parents">
            with recursive parent_users (id, parent_id, level) AS (
            SELECT id, parent_id, 1 level
            FROM location_tree
            WHERE id = #chid#
            union all
            SELECT t.id, t.parent_id, level + 1
            FROM location_tree t INNER JOIN parent_users pu
            ON t.id = pu.parent_id
            )
            SELECT * FROM parent_users WHERE parent_id IS NOT NULL;       
    </cfquery>
    <cfsavecontent variable="parentIds">
            <cfoutput query="get_all_parents">
                <li>
                        #get_all_parents.parent_id# 
                </li>
            </cfoutput>
    </cfsavecontent>
    <cfreturn parentIds />
</cffunction>


<cffunction name="getChilds" output="false" access="public">
    <cfargument name="loc_id" type="string" required="false" default="" />
    <cfset var chid = arguments.loc_id/>
    <cfquery name="get_all_childs">
        SELECT *
        FROM location_tree
        WHERE parent_id = #chid#
        UNION
        SELECT * 
        FROM location_tree
        WHERE parent_id IN 
        (SELECT ID FROM location_tree WHERE parent_id = #chid#)
        Order BY id
    </cfquery>

    <cfsavecontent variable="childIds">
        <cfoutput query="get_all_childs">
            <li>
                #get_all_childs.id# 
            </li>
        </cfoutput>
    </cfsavecontent>
    <cfreturn childIds />
</cffunction>