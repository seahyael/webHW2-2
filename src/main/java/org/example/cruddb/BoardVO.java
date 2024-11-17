package org.example.cruddb;

import java.util.Date;

public class BoardVO {
    private int seq;
    private String name;
    private String author;
    private int date;

    // Getter와 Setter
    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getDate() {
        return date;
    }

    public void setDate(int date) {
        this.date = date;
    }

    // toString 메서드 (옵션)
    @Override
    public String toString() {
        return "BoardVO{" +
                "seq=" + seq +
                ", name='" + name + '\'' +
                ", author='" + author + '\'' +
                ", date=" + date +
                '}';
    }
}
