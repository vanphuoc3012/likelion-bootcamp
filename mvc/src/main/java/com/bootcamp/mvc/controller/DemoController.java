package com.bootcamp.mvc.controller;

import com.bootcamp.mvc.service.impl.DemoServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @author Nguyen Thanh Phuong
 */
@RestController
public class DemoController {
    @Autowired
    private DemoServiceImpl demoServiceImpl;

    @GetMapping("/")
    public String viewInfoPage() {
        return demoServiceImpl.getInfo();
    }
}
