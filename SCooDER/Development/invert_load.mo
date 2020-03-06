within SCooDER.Development;
model invert_load

  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_n
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p term_p
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
equation
  connect(term_n, term_p);
  //term_p = term_n;
  /*term_n.v[1] = term_p.v[1];
  term_n.v[2] = term_p.v[2];
  term_n.i[1] = -term_p.i[1];
  term_n.i[2] = term_p.i[2];
  term_n.theta = term_p.theta;*/

end invert_load;
