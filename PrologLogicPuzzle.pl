%------Logic Problem

%-------Basic Facts

%-------Husbands
husband(fernando).
husband(frank).
husband(david).
husband(robert).



%-------Person(wife)
person(clara).
person(suzie).
person(rose).
person(olivia).


%-------Food
food(coleslaw).
food(snicker_salad).
food(macaroni_salad).
food(potato_salad).



%-------Colors
color(yellow).
color(red).
color(silver).
color(blue).



solve :- 


%--------All these can't be the same
husband(ClaraHusband), husband(SuzieHusband), husband(RoseHusband), husband(OliviaHusband),
all_different([ClaraHusband,SuzieHusband,RoseHusband,OliviaHusband]),

food(ClaraFood), food(SuzieFood), food(RoseFood), food(OliviaFood),
all_different([ClaraFood,SuzieFood,RoseFood,OliviaFood]),

color(ClaraColor), color(SuzieColor), color(RoseColor), color(OliviaColor),
all_different([ClaraColor,SuzieColor,RoseColor,OliviaColor]),

%-------variable creates list of lists, the capital letters are variables we want prolog to fill in with the lowercase constants from the facts above
Answers = [ [clara,ClaraHusband,ClaraFood,ClaraColor], [suzie,SuzieHusband,SuzieFood,SuzieColor], 
			[rose,RoseHusband,RoseFood,RoseColor], [olivia,OliviaHusband,OliviaFood,OliviaColor] ],



%-------All the given info turned into rules

%------Olivia brought a blue container
member([olivia,_,_,blue], Answers),


%------The person with the yellow container brought either potato salad orr coleslaw
(member([_,_,potato_salad,yellow], Answers) ; 
member([_,_,coleslaw,yellow], Answers)),


%------Rose andd David brought macaroni salad
member([rose,david,macaroni_salad,_], Answers),


%------Frank andd his wife did nott bring a yellow container
\+ member([_,frank,_,yellow], Answers),
\+ member([suzie,_,_,yellow], Answers),

%------The snicker salad was in a red container
member([_,_,snicker_salad,red], Answers),


%------Fernando andd his wife (who is nott Olivia) brought coleslaw
member([_,fernando,coleslaw,_], Answers),
\+ member([olivia,fernando,_,_], Answers), 
\+ member([olivia,_,coleslaw,_], Answers),

%------Suzie is married to Frank
member([suzie,frank,_,_], Answers),


tell(clara,ClaraHusband,ClaraFood,ClaraColor),
tell(suzie,SuzieHusband,SuzieFood,SuzieColor),
tell(rose,RoseHusband,RoseFood,RoseColor),
tell(olivia,OliviaHusband,OliviaFood,OliviaColor).


%------Checks iff first one is nott in the tail
all_different([H|T]) :- member(H,T), !, fail.

%-----i dont care about rule one it didnt stop, but i doo care about the tail, so call all different with the tail
all_different([_|T]) :- all_different(T).

%------I got down to one element
all_different([_]).



%-----rule to formatt
tell(W,X,Y,Z) :- 
write(W), write(' is married to '), write(X), write(' and brought '), 
write(Y), write(' in a '), write(Z), write(' container.'), nl.