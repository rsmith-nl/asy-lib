// file: dims.asy
// vim:fileencoding=utf-8:fdm=marker:ft=asy
// Functions to create dimensions.
//
// Copyright © 2016,2020 R.F. Smith <rsmith@xs4all.nl>.
// SPDX-License-Identifier: MIT
// Created: 2016-05-23T22:35:53+0200
// Last modified: 2020-10-13T21:19:34+0200


// Draw a horizontal dimension from a to b at y=c.
void hor(picture pic=currentpicture, pair a, pair b, real c, string s="",
         pen p=currentpen, real keyword offset=1, string keyword fmt="%g",
         string keyword prefix="", string keyword suffix="",
         string keyword outside="") {
    Label L;
    // Make sure that a.x < b.x!
    if (a.x > b.x) {
        pair tmp;
        tmp = a;
        a = b;
        b = tmp;
    }
    if (s == "") {
        real dx = b.x - a.x;
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
    if (outside == "") {
        draw(pic, L, (a.x, c)--(b.x, c), N, p, Arrows);
        return;
    }
    // Calculate text width
    frame f;
    label(f, L, (0,0));
    // It seems that "size" is in points?
    // Use the current transform to calculate the real width.
    real width = size(f).x / pic.calculateTransform().xx;
    if (width < arrowsize(p)) {
        width = arrowsize(p);
    }
    if (outside == "right") {
        draw(pic, L, (b.x, c)--(b.x+width, c), (0.25,1), p, arrow=BeginArrow);
        draw(pic, (a.x-arrowsize(p),c)--(a.x,c), p, arrow=EndArrow);
        return;
    }
    if (outside == "left") {
        draw(pic, L, (a.x-width, c)--(a.x, c), (-0.25,1), p, arrow=EndArrow);
        draw(pic, (b.x,c)--(b.x+arrowsize(p),c), p, arrow=BeginArrow);
    }
}



// Draw a vertical dimension from a to b at x=c.
void vert(picture pic=currentpicture, pair a, pair b, real c, string s="",
          pen p=currentpen, real keyword offset=1, string keyword fmt="%g",
          string keyword prefix="", string keyword suffix="",
          string keyword outside="") {
    Label L;
    // Make sure that a.y < b.y!
    if (a.y > b.y) {
        pair tmp;
        tmp = a;
        a = b;
        b = tmp;
    }
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
    if (outside == "") {
        draw(pic, rotate(90)*L, (c, a.y)--(c, b.y), W, p, Arrows);
        return;
    }
    // Calculate text width
    frame f;
    label(f, L, (0,0));
    // It seems that "size" is in points?
    // Use the current transform to calculate the real width.
    real width = size(f).x / pic.calculateTransform().xx;
    if (width < arrowsize(p)) {
        width = arrowsize(p);
    }
    if (outside == "above") {
        draw(pic, rotate(90)*L, (c, b.y)--(c, b.y+width), (-1, 0.25), p, arrow=BeginArrow);
        draw(pic, (c, a.y-arrowsize(p))--(c,a.y), p, arrow=EndArrow);
        return;
    }
    if (outside == "below") {
        draw(pic, rotate(90)*L, (c, a.y-width)--(c, a.y), (-1, -0.25), p, arrow=EndArrow);
        draw(pic, (c,b.y)--(c,b.y+arrowsize(p)), p, arrow=BeginArrow);
    }
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


// Draw a horizontal ruler for 10 units.
// Optionally, draw unit designation.
void ruler(picture pic=currentpicture, pair pos, pen p=currentpen, string unit="") {
    draw(pic, pos--(pos.x+10, pos.y), p);
    for (real j=0; j<=10; j+=5) {
        draw(pic, (pos.x+j,pos.y)--(pos.x+j, pos.y+2), p);
        label(pic, format("%g", j), (pos.x+j, pos.y+2), N, p);
    }
    for (real j=1; j<=4; j+=1) {
        draw(pic, (pos.x+j,pos.y)--(pos.x+j, pos.y+1), p);
        draw(pic, (pos.x+j+5,pos.y)--(pos.x+j+5, pos.y+1), p);
    }
    if (unit != "") {
        label(pic, unit, (pos.x+10, pos.y), E, p);
    }
}
