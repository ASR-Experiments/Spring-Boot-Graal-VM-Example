package dev.asr.example.graal.vm.demo.controller;


import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("")
public class IndexController {

    @Value("${message.hello-world:Hello World !!!}")
    String helloWorldMessage;

    @GetMapping
    public ResponseEntity<String> helloWorld() {
        return ResponseEntity.ok(helloWorldMessage);
    }
}
