parse(string)->
    Symbols = tokenise(String),{Tree,[]}=sentence(Symbols,),cnf(Tree).
tree(String)->
        Symbols = tokenise(String),{Tree,[]}=sentence(Symbols,),Tree.

tokenise([])->
    [];
tokenise([$n,$o,$t|Rest])->
    [{unOp, lnot}|tokenise(Rest)];
tokenise([$a,$n,$d|Rest])->
    [{binOp, land}|tokenise(Rest)];
tokenise([$o,$r|Rest])->
    [{binOp, lor}|tokenise(Rest)];
tokenise([$<,$=,$> |Rest])->
    [{binOp, equiv}|tokenise(Rest)];
tokenise([$=,$> |Rest])->
    [{binOp, implies}|tokenise(Rest)];
tokenise([$T|Rest])->
    [{lit,t}|tokenise(Rest)];
tokenise([$F|Rest])->
    [{lit,f}|tokenise(Rest)];
tokenise([$(|Rest])->
    [{sym,leftBrace}|tokenise(Rest)];
tokenise([$)|Rest])->
    [{sym,rightBrace}|tokenise(Rest)];
tokenise([$ |Rest])->
    tokenise(Rest)];
tokenise([Head|Rest])->
    [{prop,Head}|tokenise(Rest)];

sentence([{unOp , lnot}|Rest])->
    {Tree, Remainder}=sentence(Rest),
    {{lnot,Tree},Remainder};

sentence([{sym , leftBrace}|Symbols])->
    {LeftTree,[{binOp ,Op}|Remainder]}=sentence(Remainder),
    {{Op,LeftTree,RightTree},Rest};

sentence(Symbols)->
    atomic(Symbols).

atomic([{lit, P}|Rest])->
    {{lit,P},Rest};
atomic([{prop, P}|Rest])->
    {{prop,P},Rest}.
            