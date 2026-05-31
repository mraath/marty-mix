---
wiki_ingested: 2026-05-28
---
So the other repetitive part I was referring to is this:

## Current code

```c#
HttpRequestMessage requestFunc()  
            {  
                string url = $"{PostPutApiUrl}/groupIds/{groupId}/default-camera-events?authToken={authToken}";  
                var request = NewGetRequest(url, correlationId);  
                request.Headers.AcceptEncoding.TryParseAdd("gzip");  
                return request;  
            }  
            return await HttpRetries.Get<List<DefinitionEventCamera>>(requestFunc).ConfigureAwait(false);
```
            

We do this ALL the time.... we could do an extention method like such (please note I haven't tried or tested the logic... just had a quick look)

## Have this EXTENTION METHOD:

```c#
public static class HttpRequestExtensions  
{  
    public static HttpRequestMessage BuildRequest(string baseUrl, string path, string authToken, string correlationId, HttpMethod method)  
    {  
        var url = $"{baseUrl}/{path}?authToken={authToken}";  
        var request = new HttpRequestMessage(method, url);  
        request.Headers.AcceptEncoding.TryParseAdd("gzip");  
        request.Headers.Add("correlationId", correlationId);  
        return request;  
    }  
}  
```

## THEN USE IT LIKE THIS:

```c#
var request = HttpRequestExtensions.BuildRequest(PostPutApiUrl, $"groupIds/{groupId}/default-camera-events", authToken, correlationId, HttpMethod.Get);  
return await HttpRetries.Get<List<DefinitionEventCamera>>(request).ConfigureAwait(false);  
```

## Routes

We can go further to also strip out the $"groupIds/{groupId}/default-camera-events" part on keep all those in constants in a ROUTES class...

OK - enough said ![🙂](https://statics.teams.cdn.office.net/evergreen-assets/personal-expressions/v2/assets/emoticons/smile/default/30_f.png?v=v81) Let me know if I should ask Zonika about this?
