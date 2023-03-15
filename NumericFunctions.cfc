<cfcomponent output="false" displayname="NumericFuntions">

 <cfset my = structNew()/>
 <cfset my.rnd = createObject("java", "java.util.Random").init()/>
 <cfset my.min = 0/>
 <cfset my.max = 0/>
 <cfset my.cnt = 0/>
 
 <!-- Set the minimum and maximum. --->
 <cffunction name="setBounds" access="public" returnType="void" output="no">
 	<cfargument name="min" type="numeric" required="true"/>
 	<cfargument name="max" type="numeric" required="true"/>
 
 	<cfset my.min = arguments.min/>
 	<cfset my.max = arguments.max/>
 </cffunction>
 
 <!--- Set the maximum. The minimum is automatically 0. --->
 <cffunction name="setMax" access="public" returnType="void" output="no">
 	<cfargument name="max" type="numeric" required="true"/>
 	<cfset my.max = arguments.max/>
 </cffunction>
 
 <!--- Sets the seed. Accepts ints and longs (but no decimals). --->
 <cffunction name="setSeed" access="public" returnType="void" output="no">
 	<cfargument name="seed" type="string" required="true"/>
 	<cfset var l = createObject("java", "java.lang.Long").init(arguments.seed)/>
 	<cfset my.rnd.setSeed(l.longValue())/>
 </cffunction>
 
 <!--- Returns the next highly random number. --->
 <cffunction name="next" access="public" returnType="numeric" output="no">
 	<cfif my.min + my.max eq 0>
 		<cfreturn my.rnd.nextInt()/>
 	<cfelse>
 		<cfreturn (my.rnd.nextInt(javaCast("int",((my.max+1) - my.min))) + my.min)/>
 	</cfif>
 </cffunction>
 
 <!--- Returns a random boolean. --->
 <cffunction name="nextBoolean" access="public" returnType="boolean" output="no">
 	<cfreturn my.rnd.nextBoolean()/>
 </cffunction>

<cffunction name="stndDeviation" access="remote" output="false" returntype="Numeric">
            <cfargument name="arryOfNumbers"  type="Array" />

            <cfset sum    = 0>
            <cfset devsum = 0>

			<cfif arraylen(arguments.arryOfNumbers) neq 0>
            <!--- Get the Average for the Numbers --->
<!--- 
            <cfloop index="ii" from="1" to="#arraylen(arguments.arryOfNumbers)#">
                  <cfset sum = sum + arguments.arryOfNumbers[ii]>
            </cfloop>
 --->
			<cfset avgofnums = getTrimmedMean(arguments.arryOfNumbers)>

<!---             <cfset avgofnums = sum/arraylen(arguments.arryOfNumbers)>          --->
            
            <!--- Get the sum of the Deviations from the AVG --->
            <cfloop index="ii" from="1" to="#arraylen(arguments.arryOfNumbers)#">
                  <cfset devsum = devsum + (arguments.arryOfNumbers[ii] - avgofnums)*(arguments.arryOfNumbers[ii] - avgofnums)>
            </cfloop>
            
			****************************************************************************<br>
			The devsum = #devsum#<br>
			The arraylen(arguments.arryOfNumbers) is #arraylen(arguments.arryOfNumbers)#<br>
			****************************************************************************<br>
			
			<cfif arraylen(arguments.arryOfNumbers) gt 1>
            	<cfset final = devsum/(arraylen(arguments.arryOfNumbers) - 1) >
			<cfelse>
				<cfset final = devsum/(arraylen(arguments.arryOfNumbers) - 0) >
			</cfif>
            
            <cfset retval = sqr(final)>
			
		<cfelse>
			<cfset retval = 0>
		
		</cfif>	
			
            <cfreturn retval>
</cffunction>

<cffunction name="getTrimmedMean" access="remote" output="false" returntype="Numeric">
            <cfargument name="arryOfNumbers"  type="Array" />

            <cfset sum    = 0>


			<cfif arraylen(arguments.arryOfNumbers) neq 0>

            <!--- Get the Average for the Numbers --->
            <cfloop index="ii" from="1" to="#arraylen(arguments.arryOfNumbers)#">
                  <cfset sum = sum + arguments.arryOfNumbers[ii]>
            </cfloop>

            <cfset avgofnums = sum/arraylen(arguments.arryOfNumbers)>         
            <cfset sum=0>
            <!--- Get the avg of all numbers that are not 5% higher or lower than the avg --->
            <cfset goodct = 0>
                  <cfloop index="ii" from="1" to="#arraylen(arguments.arryOfNumbers)#">
                          <cfif (.10*avgofnums) + avgofnums lt arguments.arryOfNumbers[ii] or avgofnums - (.10*avgofnums) gt arguments.arryOfNumbers[ii]>
                          <cfelse>
                              <cfset goodct = goodct + 1>
                                <cfset sum = sum + arguments.arryOfNumbers[ii]>
                          </cfif>
                  </cfloop>
            
			<cfset final = 0>
			<cfif goodct neq 0>
	            <cfset final = sum/goodct>
            </cfif>
			
			
			<cfelse>
			
				<cfset final = 0>
			</cfif>
			
            <cfset retval = final>
            <cfreturn retval>
</cffunction>


<cffunction name="createSimStat" access="remote" output="false" returntype="Numeric">
	<cfargument name="BaseStat"        type="Numeric" />
	<cfargument name="StandardDevVal"  type="Numeric" />
	<cfargument name="StatPct"         type="Numeric" required="false" default=0 />
	<cfargument name="OverUnder"       type="String"  required="false" default="" />

	<cfif arguments.OverUnder neq "">
	
		<cfset temp = setBounds(1,100)>
		<cfset myval1 = next()>
	
		<cfif myval1 le arguments.StatPct>
		
			<cfif arguments.OverUnder is 'OVER'>
				<cfset multiplier = 1>
			<cfelse>
				<cfset multiplier = -1>
			</cfif>
		
		<cfelse>
		
			<cfif arguments.OverUnder is 'OVER'>
				<cfset multiplier = -1>
			<cfelse>
				<cfset multiplier = 1>
			</cfif>
		
		</cfif>		
	
	<cfelse>
		<cfset temp = setBounds(1,2)>
		<cfset myval1 = next()>
	
		<cfif myval1 is 1>
			<cfset multiplier = 1>
		<cfelse>	
			<cfset multiplier = -1>
		</cfif>

	</cfif>

    <cfset temp = setBounds(1,arguments.StandardDevVal)>
	<cfset myval = multiplier*next() + (arguments.BaseStat)>

	<cfreturn myval>


</cffunction>

</cfcomponent>