// file: patient.asy
// vim:fileencoding=utf-8:fdm=marker:ft=asy
//
// Copyright © 2017 R.F. Smith <rsmith@xs4all.nl>.
// SPDX-License-Identifier: MIT
// Created: 2017-02-04T18:13:14+0100
// Last modified: 2018-04-17T22:13:47+0200

// Draw the IEC 60601 standard patient weight distribution.
void patient(picture pic=currentpicture, real weight=0.0, string unit="kg",
             pen p=currentpen) {
    if (weight == 0.0) {
        string head = "7.4%";
        string arm = "3.7%";
        string torso = "40.7%";
        string bovenbeen = "11.1%";
        string onderbeen = "7.4%";
    } else {
        real factor = weight*100/99.9;
        string head = format("%6.1f %s", factor*7.4, unit);
        string arm = format("%6.1f %s", factor*3.7, unit);
        string torso = format("%6.1f %s", factor*40.7, unit);
        string bovenbeen = format("%6.1f %s", factor*11.1, unit);
        string onderbeen = format("%6.1f %s", factor*7.4, unit);
    }
    draw(pic, circle((90,0), 90, Label(head), p));
}
