import gradio as gr
import subprocess
import threading
import os

YOUTUBE_URL = "rtmp://a.rtmp.youtube.com/live2/68pg-phuu-b57r-xa31-aja0"  # Replace YOUR_STREAM_KEY

def start_stream(youtube_url):
    """
    Starts 24/7 live stream from a local video or static image using ffmpeg
    """
    # Using an image as a placeholder live video (loop)
    command = [
        "ffmpeg",
        "-re",
        "-stream_loop", "-1",
        "-i", "mario.gif",  # or "image.jpg"
        "-c:v", "libx264",
        "-preset", "veryfast",
        "-maxrate", "3000k",
        "-bufsize", "6000k",
        "-pix_fmt", "yuv420p",
        "-g", "50",
        "-c:a", "aac",
        "-b:a", "160k",
        "-ar", "44100",
        "-f", "flv",
        youtube_url
    ]
    subprocess.run(command)

def start_thread(youtube_url):
    t = threading.Thread(target=start_stream, args=(youtube_url,))
    t.start()
    return "Live stream started!"

with gr.Blocks() as demo:
    gr.Markdown("# Hugging Face 24/7 YouTube Live System")
    start_btn = gr.Button("Start Live Stream")
    output = gr.Textbox(label="Status")
    
    start_btn.click(start_thread, inputs=[gr.Textbox(value=YOUTUBE_URL, visible=False)], outputs=output)

demo.launch(server_name="0.0.0.0", server_port=7860)
