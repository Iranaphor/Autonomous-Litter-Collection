function sendVisionAPI(imDir, outFile)
    
    sendJson = "tosend.json";
    
%     node index C:/Users/Student/Desktop/Autonomous-Litter-Collection/b-c.png C:/Users/Student/Desktop/tosend.json
    send = "node index " + cd + '/' + imDir + " " + cd + '/' + sendJson;
    system(send);
    
%     curl -v -s -H "Content-Type: application/json" https://vision.googleapis.com/v1/images:annotate?key=AIzaSyDATQnGymR48ti77-_ru3F8BywvXBtHw2E --data-binary @tosend.json > torec.json
    send2 = 'curl -v -s -H "Content-Type: application/json" https://vision.googleapis.com/v1/images:annotate?key=AIzaSyDATQnGymR48ti77-_ru3F8BywvXBtHw2E --data-binary @' + sendJson + ' > ' + outFile;
    system(send2);
    
    
end