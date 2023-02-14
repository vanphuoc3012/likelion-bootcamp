package com.likelion.rest.entity;

import lombok.*;

import javax.persistence.*;
import java.io.Serial;
import java.io.Serializable;

/**
 * @author Nguyen Thanh Phuong
 */
@Entity
@Table(name = "TUTORIAL")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Tutorial implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "TITLE")
    private String title;

    @Column(name = "DESCRIPTION")
    private String description;

    @Column(name = "PUBLISHED")
    private boolean published;

}
