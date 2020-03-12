#docker build -t subconverter-custom:latest
#docker run -d -p 25500:25500 subconverter-custom:latest
FROM tindy2013/subconverter:latest
COPY replacements/ /base/
EXPOSE 25500