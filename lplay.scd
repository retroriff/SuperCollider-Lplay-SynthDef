(

TempoClock.default.tempo = 100/60;

SynthDef(\lplay,{
    arg amp = 0.5, buf = 0, dur = 4, out = 0, pan = 0, rel=15;
	var sig,env ;
	sig = Mix.ar(PlayBuf.ar(2, buf, ((BufFrames.ir(buf) / s.sampleRate) * TempoClock.default.tempo / dur), 1, 0, doneAction:2));
	env = EnvGen.ar(Env.linen(0.0, rel, 0), doneAction:2);
	sig = sig * env;
	sig = sig * amp;
	Out.ar(out, Pan2.ar(sig, pan));
}).add;

(
~live = Pdef(\ploop,
	Pbind(\instrument, \lplay, \buf, ~break, \dur, 4)
).play
)

)