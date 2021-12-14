package com.example.ChatApp.Utils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import org.json.JSONException;
import org.json.JSONObject;

public class Play {

    public static void main(String[] args) throws JsonProcessingException, JSONException {


//        format string to json
        ObjectMapper mapper = new ObjectMapper();

        String inputJson = "{\"one\":\"AAA\",\"two\":[\"BBB\",\"CCC\"],\"three\":{\"four\":\"DDD\",\"five\":[\"EEE\",\"FFF\"]}}";

        String json = "{\"name\":\"John\",\"age\":30,\"cars\":[\"Ford\",\"BMW\",\"Fiat\",\"Audi\",\"VW\",\"Mercedes\",\"Porsche\",\"Lamborghini\",\"Bugatti\",\"Ford\",\"BMW\",\"Fiat\",\"Audi\",\"VW\",\"Mercedes\",\"Porsche\",\"Lamborghini\",\"Bugatti\"]}";

        JSONObject json2 = new JSONObject(json); // Convert text to object
//        System.out.println(json2.toString(10));
System.out.println(json);
//        pretty print
//        System.out.println(mapper.writerWithDefaultPrettyPrinter().writeValueAsString(mapper.readTree(json)));


    }
}
