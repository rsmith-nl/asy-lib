// file: dims.asy
// vim:fileencoding=utf-8:fdm=marker:ft=asy
// Functions to create dimensions.
//
// Copyright © 2016-2017 R.F. Smith <rsmith@xs4all.nl>.
// SPDX-License-Identifier: MIT
// Created: 2016-05-23T22:35:53+0200
// Last modified: 2020-05-31T11:02:42+0200


// Draw a horizontal dimension from a to b at y=c.
void hor(picture pic=currentpicture, pair a, pair b, real c, string s="",
         pen p=currentpen, real keyword offset=1, string keyword fmt="%g",
         string keyword prefix="", string keyword suffix="") {
    Label L;
    if (s == "") {
        real dx = abs(b.x - a.x);
        L = Label(prefix + format(fmt, dx) + suffix);
    } else {
        L = Label(prefix + s + suffix);
    }
    pair as, ae, bs, be;
    if (c < a.y) {
        as = (a.x, a.y-offset);
        ae = (a.x, c-offset);
    } else {
        as = (a.x, a.y+offset);
        ae = (a.x, c+offset);
    }
    if (c < b.y) {
        bs = (b.x, b.y-offset);
        be = (b.x, c-offset);
    } else {
        bs = (b.x, b.y+offset);
        be = (b.x, c+offset);
    }
    draw(pic, as--ae, p);
    draw(pic, bs--be, p);
    draw(pic, L, (a.x, c)--(b.x, c), N, p, Arrows);
}


// Draw a vertical dimension from a to b at x=c.
void vert(picture pic=currentpicture, pair a, pair b, real c, string s="",
          pen p=currentpen, real keyword offset=1, string keyword fmt="%g",
          string keyword prefix="", string keyword suffix="") {
    Label L;
    if (s == "") {
        real dy = abs(b.y - a.y);
        L = Label(prefix + format(fmt, dy) + suffix);
    } else {
        L = Label(prefix + s + suffix);
    }
    pair as, ae, bs, be;
    if (c < a.x) {
        as = (c-offset, a.y);
        ae = (a.x-offset, a.y);
    } else {
        as = (a.x+offset, a.y);
        ae = (c+offset, a.y);
    }
    if (c < b.x) {
        bs = (c-offset, b.y);
        be = (b.x-offset, b.y);
    } else {
        bs = (b.x+offset, b.y);
        be = (c+offset, b.y);
    }
    draw(pic, as--ae, p);
    draw(pic, bs--be, p);
    draw(pic, rotate(90)*L, (c, a.y)--(c, b.y), W, p, Arrows);
}


// Draw an internal radius dimension centered on c with radius R.
// TODO: handle angles >90 and <-90!
void r_int(picture pic=currentpicture, pair c, real R, real angle, pen p=currentpen,
           real keyword length=5, string keyword fmt="%g",
           string keyword prefix="R", string keyword suffix="") {
    Label L;
    picture foo;
    L = Label(prefix+format(fmt, R)+suffix, Relative(1));
    draw(foo, L, (-R,0)--(0+length,0), NW, p, BeginArrow);
    add(pic, shift(c)*rotate(angle)*foo);
}


// Draw an external radius dimension centered on c with radius R.
// TODO: handle angles >90 and <-90!
void r_ext(picture pic=currentpicture, pair c, real R, real angle, pen p=currentpen,
           real keyword length=5, string keyword fmt="%g",
           string keyword prefix="R", string keyword suffix="") {
    Label L;
    picture foo;
    L = Label(prefix+format(fmt, R)+suffix, Relative(1));
    draw(foo, L, (R,0)--(R+length,0), NW, p, BeginArrow);
    add(pic, shift(c)*rotate(angle)*foo);
}


// Draw a horizontal scale bar for 10 units
void scale(picture pic=currentpicture, pair pos, pen p=currentpen) {
    draw(pic, pos--(pos.x+10, pos.y), p);
    for (real j=0; j<=10; j+=5) {
        draw(pic, (pos.x+j,pos.y)--(pos.x+j, pos.y+2), p);
        draw(pic, Label(format("%g", j)), (pos.x+j, pos.y+2), N, p);
    }
    for (real j=0; j<=10; j+=1) {
        draw(pic, (pos.x+j,pos.y)--(pos.x+j, pos.y+1), p);
    }
}
