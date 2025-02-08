# Audio Transcriber API

Bridge for audio transcription between Open-WebUI and Whisper, returns text in JSON format. 

**[Documentation](https://github.com/didevlab/audio-transcriber-whisper-api)** | **[GitHub](https://github.com/didevlab/audio-transcriber-whisper-api)**

## How to enable?

```
platys init --enable-services OPEN_WEBUI WHISPER
```

Set `OPEN_WEBUI_audio_transcriber_enabled` to `true`

```
platys gen
```

## How to use it?

```bash
curl -X POST http://localhost:28223/audio/transcriptions  -F "file=@path/to/your_audio_file.wav"      -F "model=base"
```


