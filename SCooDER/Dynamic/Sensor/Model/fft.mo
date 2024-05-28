within SCooDER.Dynamic.Sensor.Model;
model fft
   Modelica.Blocks.Interfaces.RealInput u annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        origin={-120,0}),iconTransformation(
        extent={{-20,-20},{20,20}},
        origin={-120,0})));

   Modelica.Blocks.Interfaces.RealOutput info "Information flag from FFT computation; = 0: FFT successfully computed"
   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={0,-110},
        rotation=-90),   iconTransformation(
        extent={{-10,-10},{10,10}},
        origin={0,-110},
        rotation=-90)));
   Modelica.Blocks.Interfaces.RealOutput amplitude
    "FFT amplitude of interested frequency band"                                                annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={110,50}),iconTransformation(
        extent={{-10,-10},{10,10}},
        origin={110,50})));
   Modelica.Blocks.Interfaces.RealOutput phase
    "FFT phase of interested frequency band"                                            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={110,-50}),
                         iconTransformation(
        extent={{-10,-10},{10,10}},
        origin={110,-50})));

  parameter Modelica.Units.SI.Frequency f_max=1000
    "Maximum frequency of interest";
  parameter Modelica.Units.SI.Frequency f_res=60 "Frequency resolution";
  parameter Integer n_out = 2 "Frequency bracket output [f_res*(nout-1) : f_res*nout]";

  //output Integer inf0(final start=0, final fixed=true)
  //  "Information flag from FFT computation; = 0: FFT successfully computed";
  output Real Ai[nfi](each start=0, each fixed=true)
    "FFT amplitudes of interested frequency points";
  output Real ph[nfi](each start=0, each fixed=true, unit="deg")
    "FFT phases of interested frequency points in [deg]";

protected
  Integer iTick(start=0, fixed=true);
  Real y_buf[ns](each start=0, each fixed=true);
  parameter Integer ns = Modelica.Math.FastFourierTransform.realFFTsamplePoints(f_max, f_res, f_max_factor=5);
  //parameter Integer ns = integer(100);
  parameter Modelica.Units.SI.Frequency f_max_FFT=f_res*div(ns, 2)
    "Maximum frequency used by FFT";
  parameter Integer nf = div(ns,2) + 1 "Number of frequency points";
  parameter Modelica.Units.SI.Time Ts=1/(2*f_max_FFT) "Sample period";
  parameter Integer nfi = max(1,min(integer(ceil(f_max/f_res))+1,nf))
    "Number of frequency points of the interested frequency range (only up to f_max)";

algorithm
  when sample(0,Ts) then
     iTick :=pre(iTick) + 1;
     if iTick >= 1 and iTick <= ns then
        y_buf[iTick] :=u;
     end if;

     if iTick == ns then
       (info, Ai, ph) :=Modelica.Math.FastFourierTransform.realFFT(y_buf, nfi);
       iTick :=0;
     end if;
  end when;
  amplitude := Ai[n_out];
  phase := ph[n_out];
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end fft;
