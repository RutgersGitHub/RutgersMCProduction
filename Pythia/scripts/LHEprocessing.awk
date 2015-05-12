# First Round: Correct the parent of the third quark

#Initialize variables (not needed, but makes code readable)
BEGIN{

}
{
	#Do this for every line
	lineprint=0;#0 if line not processed by chunk of code below, 1 otherwise (1 for six quark lines)
}

#Reset variables to 0
/<event>/ {
	#print $0
	linecount=-1;
	neutralinocount=0;
	neutralino1=-99;
	neutralino2=-99;
	quarkcount=0;
	quark5linenumber=0;
	seenquark5=0;
}

#Start processing event
{
	#Get line numbers for neutralinos	
	if($1==1000022) 
	{
		neutralinocount++;
		if(neutralinocount==1) neutralino1=linecount;
		if(neutralinocount==2) neutralino2=linecount;
	}

	#Start changing colors: Look for quarks coming from neutralinos.
	if(($3==neutralino1 || $3==neutralino2) && ($1==1 || $1==-1 || $1==2 || $1==-2 || $1==3 || $1==-3))
	{
		quarkcount++;
		#First get color and type of quark1
		if(quarkcount==1)
		{
			lineprint=1;
			printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",$1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);	
			if($1>0) 
			{
				quark1type=1; #particle
				quark1color=$5;			
			}			
			if($1<0) 
			{
				quark1type=-1; #anti-particle
				quark1color=$6;	
			}		
		}#End of processing quark1

		#Flip color and PID for quark2
		if(quarkcount==2)
		{
			lineprint=1;
			if($1>0)			
			{
				#print -$1, $2, $3, $4, 0, quark1color, $7, $8, $9, $10, $11, $12, $13; 
				printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",-$1, $2, $3, $4, 0, quark1color, $7, $8, $9, $10, $11, $12, $13);
			}
			if($1<0)			
			{
				#print -$1, $2, $3, $4, quark1color, 0, $7, $8, $9, $10, $11, $12, $13; 
				printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",-$1, $2, $3, $4, quark1color, 0, $7, $8, $9, $10, $11, $12, $13);
			}
		}#End of processing quark2

		#Get color and type for quark3
		if(quarkcount==3)
		{
			lineprint=1;
			#print $0; #print quark3 line
			#print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13;			
			printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",$1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);			
			if($1>0) 
			{
				quark3type=1; #particle
				quark3color=$5;			
			}			
			if($1<0) 
			{
				quark3type=-1; #anti-particle
				quark3color=$6;	
			}		
		}#End of processing quark3	
		
		#Get color and type for quark4
		if(quarkcount==4)
		{
			lineprint=1;
			#print $0; #print quark4 line
			#print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13;			
			printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",$1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13);			
			if($1>0) 
			{
				quark4type=1; #particle
				quark4color=$5;			
			}			
			if($1<0) 
			{
				quark4type=-1; #anti-particle
				quark4color=$6;	
			}		
		}#End of processing quark4

		#Flip color and PID for quark5
		if(quarkcount==5)
		{
			lineprint=1;
			quark5linenumber=linecount;
			seenquark5=1;
			if($1>0)			
			{
				#print -$1, $2, $3, $4, 0, quark4color, $7, $8, $9, $10, $11, $12, $13; 
				printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",-$1, $2, $3, $4, 0, quark4color, $7, $8, $9, $10, $11, $12, $13);	
			}
			if($1<0)			
			{
				#print -$1, $2, $3, $4, quark4color, 0, $7, $8, $9, $10, $11, $12, $13; 
				printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",-$1, $2, $3, $4, quark4color, 0, $7, $8, $9, $10, $11, $12, $13);
				
			}
		}#End of processing quark5		
	}

	#Flip color and set parent ID for quark 6
	if(($1==1 || $1==-1 || $1==2 || $1==-2 || $1==3 || $1==-3) && linecount==quark5linenumber+1 && seenquark5==1)	
	{
			#print "SRA: ", quark5linenumber;
			lineprint=1;			
			if($1*quark3type<0)
			{
				#if($1>0) print $1, $2, neutralino2, 0, quark3color, 0, $7, $8, $9, $10, $11, $12, $13;
				#if($1<0) print $1, $2, $3, $4, 0, quark3color, $7, $8, $9, $10, $11, $12, $13;			
				if($1>0) printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",$1, $2, neutralino2, 0, quark3color, 0, $7, $8, $9, $10, $11, $12, $13);			
				if($1<0) printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",$1, $2, neutralino2, 0, 0, quark3color, $7, $8, $9, $10, $11, $12, $13);
			}
			if($1*quark3type>0)
			{
				#if($1>0) print -$1, $2, neutralino2, 0, 0, quark3color, $7, $8, $9, $10, $11, $12, $13;
				#if($1<0) print -$1, $2, $3, $4, quark3color, 0, $7, $8, $9, $10, $11, $12, $13;	
				if($1>0) printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",-$1, $2, neutralino2, 0, 0, quark3color, $7, $8, $9, $10, $11, $12, $13);
				if($1<0) printf("%8d %4d %4d %4d %4d %4d %17s %17s %17s %17s %17s %2s %2s\n",-$1, $2, neutralino2, 0, quark3color, 0, $7, $8, $9, $10, $11, $12, $13);
			}
	}
	linecount++;
}

{
	if(lineprint==0) print $0;
}
END {
}

