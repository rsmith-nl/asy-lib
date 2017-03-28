// file: patient.asy
// vim:fileencoding=utf-8:ft=asy
//
// Author: R.F. Smith <rsmith@xs4all.nl>
// Created: 2017-02-04 18:13:14 +0100
// Last modified: 2017-02-04 18:30:51 +0100
//
// To the extent possible under law, R.F. Smith has waived all copyright and
// related or neighboring rights to patient.asy. This work is published
// from the Netherlands. See http://creativecommons.org/publicdomain/zero/1.0/

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
