// file: dims.asy
// vim:fileencoding=utf-8:fdm=marker:ft=asy
// Functions to create dimensions.
//
// Copyright © 2016-2017 R.F. Smith <rsmith@xs4all.nl>.
// SPDX-License-Identifier: MIT
// Created: 2016-05-23T22:35:53+0200
// Last modified: 2018-04-17T22:13:12+0200


// Draw a horizontal dimension from a to b at y=c.
void hor(picture pic=currentpicture, pair a, pair b, real c, string s="",
         pen p=currentpen, real keyword offset=1, string keyword fmt="%g",
         string keyword prefix="", string keyword suffix="") {
    Label L;
    if (s == "") {
        real dx = abs(b.x - a.x);
        L = Label(format(fmt, dx));
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
        L = Label(format(fmt, dy));
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




