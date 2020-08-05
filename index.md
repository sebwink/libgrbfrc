## libgrbfrc - Solving mixed-integer fractional programs

### Documentation 

[Documentation for users](docs/use/index.md)

[Detailed documentation for developers and other interested entities](docs/dev/index.md)

### Examples 

```cpp 
 #include <gurobi_c++.h>
 #include "grbfrc.hpp"
 
 using FMILP = grbfrc::FMILP;
 
 int main()
  {
   GRBEnv env;
   FMILP model(env);
   GRBVar x = model.addVar(0.0, GRB_INFINITY, GRB_CONTINUOUS, "x");
   GRBVar y = model.addVar(0.0, GRB_INFINITY, GRB_CONTINUOUS, "y");
   GRBVar z = model.addVar(0.0, GRB_INFINITY, GRB_CONTINUOUS, "z");
   model.update();
   model.addConstr( x + 3*y + z <= 10 );
   model.addConstr( 3*x + 2*y <= 7 );
   GRBLinExpr objNum { 2*x + y + 3*z + 6 };
   model.setObjNumerator(objNum);
   GRBLinExpr objDenom { x + 3*z + 4 };
   model.setObjDenominator(objDenom);
   model.setObjSense(GRB_MAXIMIZE);
   model.optimize(grbfrc::Algorithm::CCT);
   model.printSolution();
  }
```

More examples:

[Examples](https://github.com/sebwink/libgrbfrc/tree/master/examples)
