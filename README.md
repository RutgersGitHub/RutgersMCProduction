Note: The MC production document may be found in Documentation/tmp/RutgersMCGeneration_temp.pdf
Instructions on how to edit and recompile the pdf file may be found in
RutgersMultileptonDocs/MCProduction/Documentation/README.txt

Reasons on why we should have a Monte Carlo generation note and what should be in it. 
You may have noticed that our group generated a lot of signals over the past few years, 
including those for several large collaborative efforts. The reason is that most groups 
do not have this capability, and for that reason, are forced to rely on other people to 
make it for them. This severely hinders the pace at which analyses can be produced and 
reduces the freedom to introduce new analyses. You may or may not have noticed that the 
official signal samples contained errors at a very high rate, which happened much less 
frequently when we produced our own samples (not that we were perfect).

I would like to be sure that we retain this expertise going forward. What I am envisioning 
is that we have a note that will make it easy for a new student to jump into being able generate 
MC themselves and to know what things to look for to make sure every step worked properly.

What I have in mind is to have sections on each of the major tools used in MC generation 
that explains what each one does, what major settings to understand, and how it fits in with 
common work flows.

For example, I think there are 6 major work flows that we use with some variations:

1) Pythia -> CMS
2) SLHA -> Pythia -> CMS
3) Pythia -> LHE -> CMS
4) SLHA -> Pythia -> LHE -> CMS
5) MadGraph -> Pythia -> CMS
6) SLHA -> MadGraph -> Pythia -> CMS

There's also Bridge, which fits in somewhere. So I'd like sections on SLHA's, MadGraph, and 
Pythia with explanations for what to do for the different input/output/workflow. It's important 
to also include a list of common pitfalls to avoid. There should be lots of examples.

I would also like to see a lot of discussion of validation, especially jet-matching. What we 
can also do is work on developing some tools in the new framework to make validation easy.
