#===================================================================================================================
# Author: Sanjay Arora (srarora@physics.rutgers.edu)
# Running: awk -f slhaprocessing.awk input.slha > output.slha
#
#
#===================================================================================================================

# We need to make 6 changes to the slha file. For sake of clarity, we'll make these changes in separate modules with this file.

BEGIN{
    linecount = -1;#variable to keep track of which line number is being processed
    charginodecayline = -99; #line where chargino decay is specified
    stauwidth = -99; #variable to store er- width, which is used as the stau width
    lineprocessed=0;#variable=1 when line changed by code below, 0 otherwise
    staudecayline = -99; #line where stau decay table starts
}

{
    #For each new line, reset lineprocessed to 0
    lineprocessed=0;

    #Change chargino mass
    if($1==1000022)
    {
	neutralinomass = $2;
    }
    if($1==1000024)
    {
	printf("%10d %18.8E %3s %5s\n",$1,neutralinomass+2, $3, $4); #Fix 1: Change mass notation to scientific notation
	lineprocessed=1;
    }
    #End of changing chargino mass
    
    #Chargino width and branching ratios:
    #Change chargino width
    if($1=="DECAY" && $2==1000024)
    {
	charginowidth = 0.02;
	printf("%5s %9s %15.8E %16s\n",$1, $2, charginowidth, "# WISS+ decays");
	charginodecayline=linecount;
	lineprocessed=1;
    }

    #Change chargino branching ratio
    if(linecount==charginodecayline+2)
    {
	#printf("%s\n", $0);
	printf("%20.8E %4s %12s %9s %9s %42s\n" , $1, $2, $3, 2, -1, "# W1SS+  -->  Z1SS   UP     DB");
	lineprocessed = 1;
    }
    #End of changing chargino width and branching ratios

    #Get width of stau from ER-
    if($1=="DECAY" && $2==2000011)
    {
	stauwidth = $3;
    }
    #End of getting stau width

    linecount++;
    
    #Make sure old stau decay table is not processed
    if($1=="DECAY" && $2==1000015) #can do this above, but more readable this way
    {
	lineprocessed=1;
	staudecayline = linecount;
    }
    if(linecount==staudecayline+1 || linecount==staudecayline+2 || linecount==staudecayline+3)
    {
	lineprocessed=1;
    }
    #End of running over old stau decay table

    #Print out line if not processed by above code
    if(lineprocessed==0)
    {
	print $0;
    }
}
#Add neutralino decays and stau decays (as well as width)
END{

    #Add neutralino decays: This is missing in the unprocessed slha file. Add lines to end of slha file
    #Note: This is extremely specific i.e. hard-coded values.
    print("# H-RPV Decays of neutralino_1");
    print("#         PDG         Width");
    printf("%5s %10s %16.8E %4s %13s\n", "DECAY", 1000022, 1," #", "Z1SS decays"); 
    printf("%1s %12s %5s %5s %5s %5s\n", "#", "BR", "NDA", "ID1", "ID2", "ID3", "ID4");
    printf("%20.8E %5s %5s %5s %5s\n", 0.5, 3, 1, 2, 3, "# Z1SS--> u d s");
    printf("%20.8E %5s %5s %5s %5s\n", 0.5, 3, -1, -2, -3, "$Z1SS--> ubar dbar sbar")

    #Stau decay table
    print("# H-RPV Decays of stau_1");
    print("#         PDG         Width");
    printf("%5s %10s %16.8E %4s %13s\n", "DECAY", 1000015, stauwidth," #", "TAU1- decays"); 
    printf("%1s %12s %5s %5s %5s %5s\n", "#", "BR", "NDA", "ID1", "ID2", "ID3", "ID4");
    printf("%20.8E %5s %5s %5s %15s\n", 1.0, 2, 1000022, 15 , "# TAU1--> u Z1SS TAU-");
}
