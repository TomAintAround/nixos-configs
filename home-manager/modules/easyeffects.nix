{
	services.easyeffects = {
		enable = true;
		preset = "Default";
	};

	xdg.configFile."easyeffects/input/Default.json".text = ''
{
	"input": {
		"blocklist": [],
		"compressor#0": {
			"attack": 1.0,
			"boost-amount": 6.0,
			"boost-threshold": -60.0,
			"bypass": false,
			"dry": -100.0,
			"hpf-frequency": 10.0,
			"hpf-mode": "off",
			"input-gain": 0.0,
			"knee": -6.0,
			"lpf-frequency": 20000.0,
			"lpf-mode": "off",
			"makeup": 25.0,
			"mode": "Downward",
			"output-gain": 0.0,
			"ratio": 4.5,
			"release": 300.0,
			"release-threshold": -1.0269562977782698e-15,
			"sidechain": {
			"lookahead": 0.0,
			"mode": "RMS",
			"preamp": 0.0,
			"reactivity": 10.0,
			"source": "Middle",
			"stereo-split-source": "Left/Right",
			"type": "Feed-forward"
			},
			"stereo-split": false,
			"threshold": -17.5,
			"wet": 0.0
		},
		"limiter#0": {
			"alr": false,
			"alr-attack": 5.0,
			"alr-knee": 0.0,
			"alr-release": 50.0,
			"attack": 1.0,
			"bypass": false,
			"dithering": "None",
			"external-sidechain": false,
			"gain-boost": false,
			"input-gain": 0.0,
			"lookahead": 5.0,
			"mode": "Herm Thin",
			"output-gain": 0.0,
			"oversampling": "None",
			"release": 20.0,
			"sidechain-preamp": 0.0,
			"stereo-link": 100.0,
			"threshold": -2.5
		},
		"plugins_order": [
			"compressor#0",
			"rnnoise#0",
			"limiter#0",
			"stereo_tools#0"
		],
		"rnnoise#0": {
			"bypass": false,
			"enable-vad": true,
			"input-gain": 0.0,
			"model-name": "",
			"output-gain": 0.0,
			"release": 300.0,
			"vad-thres": 50.0,
			"wet": 0.0
		},
		"stereo_tools#0": {
			"balance-in": 0.0,
			"balance-out": 0.0,
			"bypass": false,
			"delay": 0.0,
			"input-gain": 0.0,
			"middle-level": 0.0,
			"middle-panorama": 0.0,
			"mode": "LR > LL (Mono Left Channel)",
			"mutel": false,
			"muter": false,
			"output-gain": 0.0,
			"phasel": false,
			"phaser": false,
			"sc-level": 1.0,
			"side-balance": 0.0,
			"side-level": 0.0,
			"softclip": false,
			"stereo-base": 0.0,
			"stereo-phase": 0.0
		}
	}
} 
	'';

	xdg.configFile."easyeffects/output/Default.json".text = ''
{
	"output": {
		"blocklist": [],
		"limiter#0": {
			"alr": false,
			"alr-attack": 5.0,
			"alr-knee": 0.0,
			"alr-release": 50.0,
			"attack": 1.0,
			"bypass": false,
			"dithering": "None",
			"external-sidechain": false,
			"gain-boost": true,
			"input-gain": 0.0,
			"lookahead": 5.0,
			"mode": "Herm Thin",
			"output-gain": 0.0,
			"oversampling": "None",
			"release": 20.0,
			"sidechain-preamp": 0.0,
			"stereo-link": 100.0,
			"threshold": -2.5
		},
		"plugins_order": [
			"limiter#0"
		]
	}
}
	'';
}
