<cfcomponent displayname="Random" output="no">
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
 </cfcomponent>
