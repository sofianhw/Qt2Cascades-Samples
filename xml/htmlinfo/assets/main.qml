/****************************************************************************
 **
 ** Portions Copyright (C) 2012 Research In Motion Limited.
 ** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
 ** All rights reserved.
 ** Contact: Research In Motion Ltd. (http://www.rim.com/company/contact/)
 ** Contact: Nokia Corporation (qt-info@nokia.com)
 **
 ** This file is part of the examples of the BB10 Platform and is derived
 ** from a similar file that is part of the Qt Toolkit.
 **
 ** You may use this file under the terms of the BSD license as follows:
 **
 ** "Redistribution and use in source and binary forms, with or without
 ** modification, are permitted provided that the following conditions are
 ** met:
 **   * Redistributions of source code must retain the above copyright
 **     notice, this list of conditions and the following disclaimer.
 **   * Redistributions in binary form must reproduce the above copyright
 **     notice, this list of conditions and the following disclaimer in
 **     the documentation and/or other materials provided with the
 **     distribution.
 **   * Neither the name of Research In Motion, nor the name of Nokia
 **     Corporation and its Subsidiary(-ies), nor the names of its
 **     contributors may be used to endorse or promote products
 **     derived from this software without specific prior written
 **     permission.
 **
 ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 ** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 ** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 ** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 ** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 ** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 ** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 ** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 **
 ****************************************************************************/


import bb.cascades 1.0


// Page shows different HTML file selections in a ListView that will be parsed using a xml
// reader and statistics about the file will be displayed
Page {
    content: Container {
        layout: DockLayout {}

        // The background image
        ImageView {
            layoutProperties: DockLayoutProperties {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
            }

            imageSource: "asset:///images/background.png"
        }


        ScrollView {
            layoutProperties: DockLayoutProperties {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
            }

            scrollViewProperties {
                scrollMode: ScrollMode.Vertical
            }

            Container {
                layout: StackLayout {
                    topPadding: 150
                    leftPadding: 30
                    rightPadding: 30
                }

                // A standard TextArea for displaying any parse errors
                TextArea {
                    preferredWidth: 680
                    preferredHeight: 360
                    editable: false

                    // Make this Container visible only if there are errors
                    visible: _htmlInfo.error != ""

                    text: _htmlInfo.error

                    // Defines custom text style
                    textStyle {
                        base: SystemDefaults.TextStyles.SmallText
                        color: Color.DarkRed
                        alignment: TextAlignment.Center
                    }
                }

                Container {
                    // Container grouping HTML parsed output only visible if there were no errors
                    visible: _htmlInfo.error == ""

                    // A standard TextArea for displaying the HTML head title
                    TextArea {
                        preferredWidth: 700
                        backgroundVisible: false

                        text: _htmlInfo.title

                        // Defines text style
                        textStyle {
                            base: SystemDefaults.TextStyles.TitleText
                            color: Color.White
                            alignment: TextAlignment.Center
                        }
                    }

                    // A divider line
                    ImageView {
                        imageSource: "asset:///images/divider.png"
                    }

                    // Container grouping the Label and the corresponding output
                    Container {
                        layoutProperties: StackLayoutProperties {
                            horizontalAlignment: HorizontalAlignment.Fill
                        }

                        layout: StackLayout {
                            layoutDirection: LayoutDirection.LeftToRight
                            leftPadding: 30
                            rightPadding: 30
                        }

                        // A standard Label
                        Label {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }

                            text: qsTr ("Number of paragraphs")

                            textStyle {
                                base: SystemDefaults.TextStyles.SmallText
                                color: Color.White
                            }
                        }

                        // A standard Label displaying paragraphs output
                        Label {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }

                            text: _htmlInfo.paragraphs

                            textStyle {
                                alignment: TextAlignment.ForceRight
                                base: SystemDefaults.TextStyles.SmallText
                                color: Color.White
                            }
                        }
                    }

                    // A divider line
                    ImageView {
                        imageSource: "asset:///images/divider.png"
                    }

                    // Container grouping the Label and the corresponding output
                    Container {
                        layoutProperties: StackLayoutProperties {
                            horizontalAlignment: HorizontalAlignment.Fill
                        }

                        layout: StackLayout {
                            layoutDirection: LayoutDirection.LeftToRight
                            leftPadding: 30
                            rightPadding: 30
                        }

                        // A standard Label
                        Label {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }

                            text: qsTr ("Number of links:")

                            textStyle {
                                base: SystemDefaults.TextStyles.SmallText
                                color: Color.White
                            }
                        }

                        // A standard Label displaying number of links output
                        Label {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }

                            text: _htmlInfo.links

                            textStyle {
                                alignment: TextAlignment.ForceRight
                                base: SystemDefaults.TextStyles.SmallText
                                color: Color.White
                            }
                        }
                    }

                    // A divider line
                    ImageView {
                        imageSource: "asset:///images/divider.png"
                    }

                    ////////////

                    // Container grouping the Label and the corresponding output
                    Container {
                        layout: StackLayout {
                            leftPadding: 30
                            rightPadding: 30
                        }

                        // A standard TextArea displaying link url's
                        TextArea {
                            preferredWidth: 850
                            editable: false

                            text: _htmlInfo.linksContent

                            // Defines text style
                            textStyle {
                                base: SystemDefaults.TextStyles.SmallText
                                color: Color.Gray
                            }
                        }
                    }
                }
            }
        }

        SlideoutPanel {
            layoutProperties: StackLayoutProperties {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Top
            }

            translationY: -444

            onClicked: {
                if (translationY == 0)
                    slideOut.play()
                else
                    slideIn.play()
            }

            animations: [
                TranslateTransition {
                    id: slideIn
                    fromY: -444
                    toY: 0
                    easingCurve: StockCurve.BackInOut
                    duration: 800
                },
                TranslateTransition {
                    id: slideOut
                    fromY: 0
                    toY: -444
                    easingCurve: StockCurve.BackInOut
                    duration: 800
                }
            ]
        }
    }
}