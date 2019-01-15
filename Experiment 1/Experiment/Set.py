#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
This experiment was created using PsychoPy2 Experiment Builder (v1.84.2),
    on 2017_03_19_1926
If you publish work using this script please cite the PsychoPy publications:
    Peirce, JW (2007) PsychoPy - Psychophysics software in Python.
        Journal of Neuroscience Methods, 162(1-2), 8-13.
    Peirce, JW (2009) Generating stimuli for neuroscience using PsychoPy.
        Frontiers in Neuroinformatics, 2:10. doi: 10.3389/neuro.11.010.2008
"""

from __future__ import absolute_import, division
from psychopy import locale_setup, gui, visual, core, data, event, logging, sound
from psychopy.constants import (NOT_STARTED, STARTED, PLAYING, PAUSED,
                                STOPPED, FINISHED, PRESSED, RELEASED, FOREVER)
import numpy as np  # whole numpy lib is available, prepend 'np.'
from numpy import (sin, cos, tan, log, log10, pi, average,
                   sqrt, std, deg2rad, rad2deg, linspace, asarray)
from numpy.random import random, randint, normal, shuffle
import os  # handy system and path functions
import sys  # to get file system encoding

# Ensure that relative paths start from the same directory as this script
_thisDir = os.path.dirname(os.path.abspath(__file__)).decode(sys.getfilesystemencoding())
os.chdir(_thisDir)

# Store info about the experiment session
expName = 'Set'  # from the Builder filename that created this script
expInfo = {u'gender': u'', u'age': u'', u'participant': u''}
dlg = gui.DlgFromDict(dictionary=expInfo, title=expName)
if dlg.OK == False:
    core.quit()  # user pressed cancel
expInfo['date'] = data.getDateStr()  # add a simple timestamp
expInfo['expName'] = expName

# Data file name stem = absolute path + name; later add .psyexp, .csv, .log, etc
filename = _thisDir + os.sep + u'data/%s_%s_%s' % (expInfo['participant'], expName, expInfo['date'])

# An ExperimentHandler isn't essential but helps with data saving
thisExp = data.ExperimentHandler(name=expName, version='',
    extraInfo=expInfo, runtimeInfo=None,
    originPath=None,
    savePickle=True, saveWideText=True,
    dataFileName=filename)
# save a log file for detail verbose info
logFile = logging.LogFile(filename+'.log', level=logging.EXP)
logging.console.setLevel(logging.WARNING)  # this outputs to the screen, not a file

endExpNow = False  # flag for 'escape' or other condition => quit the exp

# Start Code - component code to be run before the window creation

# Setup the Window
win = visual.Window(
    size=(1920, 1080), fullscr=True, screen=0,
    allowGUI=False, allowStencil=False,
    monitor='testMonitor', color=[0,0,0], colorSpace='rgb',
    blendMode='avg', useFBO=True)
# store frame rate of monitor if we can measure it
expInfo['frameRate'] = win.getActualFrameRate()
if expInfo['frameRate'] != None:
    frameDur = 1.0 / round(expInfo['frameRate'])
else:
    frameDur = 1.0 / 60.0  # could not measure, so guess

# Initialize components for Routine "instruction"
instructionClock = core.Clock()
text_2 = visual.TextStim(win=win, name='text_2',
    text=u'\u0417\u0430\u043a\u0440\u043e\u0439\u0442\u0435 \u043b\u0435\u0432\u044b\u0439 \u0433\u043b\u0430\u0437.\n\u0421\u0435\u0439\u0447\u0430\u0441 \u0432\u0430\u043c \u0431\u0443\u0434\u0443\u0442 \u043f\u043e\u043a\u0430\u0437\u0430\u043d\u044b \u043f\u0430\u0440\u044b \u043a\u0440\u0443\u0433\u043e\u0432. \u041f\u043e\u0436\u0430\u043b\u0443\u0439\u0441\u0442\u0430, \u0441\u0442\u0430\u0440\u0430\u0439\u0442\u0435\u0441\u044c \u0441\u043c\u043e\u0442\u0440\u0435\u0442\u044c \u0442\u043e\u043b\u044c\u043a\u043e \u0432 \u0446\u0435\u043d\u0442\u0440\u0430\u043b\u044c\u043d\u0443\u044e \u0442\u043e\u0447\u043a\u0443. \u041f\u043e\u0441\u043b\u0435 \u043d\u0435\u0441\u043a\u043e\u043b\u044c\u043a\u0438\u0445 \u043f\u0440\u0435\u0434\u044a\u044f\u0432\u043b\u0435\u043d\u0438\u0439 \u0432\u0430\u043c \u0431\u0443\u0434\u0435\u0442 \u0437\u0430\u0434\u0430\u043d \u0432\u043e\u043f\u0440\u043e\u0441 \u043e \u0442\u043e\u043c, \u0432 \u043a\u0430\u043a\u043e\u043c \u043e\u0442\u043d\u043e\u0448\u0435\u043d\u0438\u0438 \u0431\u044b\u043b\u0438 \u041f\u041e\u0421\u041b\u0415\u0414\u041d\u0418\u0415 \u041f\u0420\u0415\u0414\u042a\u042f\u0412\u041b\u0415\u041d\u041d\u042b\u0415 \u043a\u0440\u0443\u0433\u0438. \u0414\u0430\u043b\u0435\u0435 \u043f\u0440\u043e\u0446\u0435\u0434\u0443\u0440\u0430 \u043f\u043e\u0432\u0442\u043e\u0440\u0438\u0442\u0441\u044f. \n\n\u0416\u0435\u043b\u0430\u044e \u0442\u0435\u0440\u043f\u0435\u043d\u0438\u044f \u0438 \u0432\u043d\u0438\u043c\u0430\u0442\u0435\u043b\u044c\u043d\u043e\u0441\u0442\u0438!\n\n\u041d\u0430\u0436\u043c\u0438\u0442\u0435 \u041f\u0420\u041e\u0411\u0415\u041b \u043f\u043e\u0441\u043b\u0435 \u0442\u043e\u0433\u043e, \u043a\u0430\u043a \u0431\u0443\u0434\u0435\u0442\u0435 \u0433\u043e\u0442\u043e\u0432\u044b \u043f\u0440\u0438\u0441\u0442\u0443\u043f\u0438\u0442\u044c \u043a \u0432\u044b\u043f\u043e\u043b\u043d\u0435\u043d\u0438\u044e \u0437\u0430\u0434\u0430\u043d\u0438\u044f.',
    font='Arial',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1,
    depth=0.0);

# Initialize components for Routine "fixation"
fixationClock = core.Clock()
polygon = visual.Polygon(
    win=win, name='polygon',units='cm', 
    edges=90, size=[1.0, 1.0],
    ori=0, pos=(3, 0),
    lineWidth=1, lineColor=[1,1,1], lineColorSpace='rgb',
    fillColor=[1,1,1], fillColorSpace='rgb',
    opacity=1, depth=0.0, interpolate=True)
polygon_2 = visual.Polygon(
    win=win, name='polygon_2',units='cm', 
    edges=90, size=(2.5,2.5),
    ori=0, pos=(-3, 0),
    lineWidth=1, lineColor=[1,1,1], lineColorSpace='rgb',
    fillColor=[1,1,1], fillColorSpace='rgb',
    opacity=1, depth=-1.0, interpolate=True)
polygon_5 = visual.Polygon(
    win=win, name='polygon_5',units='cm', 
    edges=90, size=(0.1, 0.1),
    ori=0, pos=(0, 0),
    lineWidth=1, lineColor=[1,1,1], lineColorSpace='rgb',
    fillColor=[50,1,1], fillColorSpace='rgb',
    opacity=1, depth=-2.0, interpolate=True)


# Initialize components for Routine "test"
testClock = core.Clock()
polygon_3 = visual.Polygon(
    win=win, name='polygon_3',units='cm', 
    edges=90, size=(2.5, 2.5),
    ori=0, pos=(3, 0),
    lineWidth=1, lineColor=[1,1,1], lineColorSpace='rgb',
    fillColor=[1,1,1], fillColorSpace='rgb',
    opacity=1, depth=0.0, interpolate=True)
polygon_4 = visual.Polygon(
    win=win, name='polygon_4',units='cm', 
    edges=90, size=(2.5, 2.5),
    ori=0, pos=(-3, 0),
    lineWidth=1, lineColor=[1,1,1], lineColorSpace='rgb',
    fillColor=[1,1,1], fillColorSpace='rgb',
    opacity=1, depth=-1.0, interpolate=True)
text = visual.TextStim(win=win, name='text',
    text=u'\u0412 \u043a\u0430\u043a\u043e\u043c \u043e\u0442\u043d\u043e\u0448\u0435\u043d\u0438\u0438 \u0431\u044b\u043b\u0438 \u043a\u0440\u0443\u0433\u0438? ("\u0432\u043b\u0435\u0432\u043e" - \u043b\u0435\u0432\u044b\u0439 \u0431\u043e\u043b\u044c\u0448\u0435, "\u0432\u043f\u0440\u0430\u0432\u043e" - \u043f\u0440\u0430\u0432\u044b\u0439 \u0431\u043e\u043b\u044c\u0448\u0435, "\u0432\u043d\u0438\u0437" - \u0440\u0430\u0432\u043d\u044b)\n',
    font='Arial',
    pos=(0, 0.3), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1,
    depth=-3.0);
polygon_6 = visual.Polygon(
    win=win, name='polygon_6',units='cm', 
    edges=90, size=(0.1, 0.1),
    ori=0, pos=(0, 0),
    lineWidth=1, lineColor=[1,1,1], lineColorSpace='rgb',
    fillColor=[50,1,1], fillColorSpace='rgb',
    opacity=1, depth=-4.0, interpolate=True)
myequal = 0

# Initialize components for Routine "rest"
restClock = core.Clock()
text_3 = visual.TextStim(win=win, name='text_3',
    text=u'\u0412\u044b \u043c\u043e\u0436\u0435\u0442\u0435 \u043e\u0442\u0434\u043e\u0445\u043d\u0443\u0442\u044c.\n\n\u041d\u0430\u0436\u043c\u0438\u0442\u0435 \u041f\u0420\u041e\u0411\u0415\u041b, \u043a\u043e\u0433\u0434\u0430 \u0431\u0443\u0434\u0435\u0442\u0435 \u0433\u043e\u0442\u043e\u0432\u044b \u043f\u0440\u0438\u0441\u0442\u0443\u043f\u0438\u0442\u044c \u043a \u0437\u0430\u0434\u0430\u043d\u0438\u044e.',
    font='Arial',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1,
    depth=0.0);

# Initialize components for Routine "thank_you"
thank_youClock = core.Clock()
text_4 = visual.TextStim(win=win, name='text_4',
    text=u'\u042d\u043a\u0441\u043f\u0435\u0440\u0438\u043c\u0435\u043d\u0442 \u043e\u043a\u043e\u043d\u0447\u0435\u043d.\n\n\u0421\u043f\u0430\u0441\u0438\u0431\u043e \u0437\u0430 \u0443\u0447\u0430\u0441\u0442\u0438\u0435!',
    font='Arial',
    pos=(0, 0), height=0.1, wrapWidth=None, ori=0, 
    color='white', colorSpace='rgb', opacity=1,
    depth=0.0);

# Create some handy timers
globalClock = core.Clock()  # to track the time since experiment started
routineTimer = core.CountdownTimer()  # to track time remaining of each (non-slip) routine 

# ------Prepare to start Routine "instruction"-------
t = 0
instructionClock.reset()  # clock
frameN = -1
continueRoutine = True
# update component parameters for each repeat
key_resp_3 = event.BuilderKeyResponse()
# keep track of which components have finished
instructionComponents = [text_2, key_resp_3]
for thisComponent in instructionComponents:
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "instruction"-------
while continueRoutine:
    # get current time
    t = instructionClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *text_2* updates
    if t >= 0.0 and text_2.status == NOT_STARTED:
        # keep track of start time/frame for later
        text_2.tStart = t
        text_2.frameNStart = frameN  # exact frame index
        text_2.setAutoDraw(True)
    
    # *key_resp_3* updates
    if t >= 0.0 and key_resp_3.status == NOT_STARTED:
        # keep track of start time/frame for later
        key_resp_3.tStart = t
        key_resp_3.frameNStart = frameN  # exact frame index
        key_resp_3.status = STARTED
        # keyboard checking is just starting
        event.clearEvents(eventType='keyboard')
    if key_resp_3.status == STARTED:
        theseKeys = event.getKeys(keyList=['space'])
        
        # check for quit:
        if "escape" in theseKeys:
            endExpNow = True
        if len(theseKeys) > 0:  # at least one key was pressed
            # a response ends the routine
            continueRoutine = False
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in instructionComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # check for quit (the Esc key)
    if endExpNow or event.getKeys(keyList=["escape"]):
        core.quit()
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "instruction"-------
for thisComponent in instructionComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)
# the Routine "instruction" was not non-slip safe, so reset the non-slip timer
routineTimer.reset()

# set up handler to look after randomisation of conditions etc
trials_2 = data.TrialHandler(nReps=2, method='random', 
    extraInfo=expInfo, originPath=-1,
    trialList=data.importConditions('set_conditions.csv'),
    seed=None, name='trials_2')
thisExp.addLoop(trials_2)  # add the loop to the experiment
thisTrial_2 = trials_2.trialList[0]  # so we can initialise stimuli with some values
# abbreviate parameter names if possible (e.g. rgb = thisTrial_2.rgb)
if thisTrial_2 != None:
    for paramName in thisTrial_2.keys():
        exec(paramName + '= thisTrial_2.' + paramName)

for thisTrial_2 in trials_2:
    currentLoop = trials_2
    # abbreviate parameter names if possible (e.g. rgb = thisTrial_2.rgb)
    if thisTrial_2 != None:
        for paramName in thisTrial_2.keys():
            exec(paramName + '= thisTrial_2.' + paramName)
    
    # set up handler to look after randomisation of conditions etc
    trials = data.TrialHandler(nReps=number_of_fixational_trials, method='random', 
        extraInfo=expInfo, originPath=-1,
        trialList=[None],
        seed=None, name='trials')
    thisExp.addLoop(trials)  # add the loop to the experiment
    thisTrial = trials.trialList[0]  # so we can initialise stimuli with some values
    # abbreviate parameter names if possible (e.g. rgb = thisTrial.rgb)
    if thisTrial != None:
        for paramName in thisTrial.keys():
            exec(paramName + '= thisTrial.' + paramName)
    
    for thisTrial in trials:
        currentLoop = trials
        # abbreviate parameter names if possible (e.g. rgb = thisTrial.rgb)
        if thisTrial != None:
            for paramName in thisTrial.keys():
                exec(paramName + '= thisTrial.' + paramName)
        
        # ------Prepare to start Routine "fixation"-------
        t = 0
        fixationClock.reset()  # clock
        frameN = -1
        continueRoutine = True
        routineTimer.add(1.000000)
        # update component parameters for each repeat
        polygon.setSize(size)
        
        # keep track of which components have finished
        fixationComponents = [polygon, polygon_2, polygon_5]
        for thisComponent in fixationComponents:
            if hasattr(thisComponent, 'status'):
                thisComponent.status = NOT_STARTED
        
        # -------Start Routine "fixation"-------
        while continueRoutine and routineTimer.getTime() > 0:
            # get current time
            t = fixationClock.getTime()
            frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
            # update/draw components on each frame
            
            # *polygon* updates
            if t >= 0.4 and polygon.status == NOT_STARTED:
                # keep track of start time/frame for later
                polygon.tStart = t
                polygon.frameNStart = frameN  # exact frame index
                polygon.setAutoDraw(True)
            frameRemains = 0.4 + 0.15- win.monitorFramePeriod * 0.75  # most of one frame period left
            if polygon.status == STARTED and t >= frameRemains:
                polygon.setAutoDraw(False)
            
            # *polygon_2* updates
            if t >= 0.4 and polygon_2.status == NOT_STARTED:
                # keep track of start time/frame for later
                polygon_2.tStart = t
                polygon_2.frameNStart = frameN  # exact frame index
                polygon_2.setAutoDraw(True)
            frameRemains = 0.4 + 0.15- win.monitorFramePeriod * 0.75  # most of one frame period left
            if polygon_2.status == STARTED and t >= frameRemains:
                polygon_2.setAutoDraw(False)
            
            # *polygon_5* updates
            if t >= 0.0 and polygon_5.status == NOT_STARTED:
                # keep track of start time/frame for later
                polygon_5.tStart = t
                polygon_5.frameNStart = frameN  # exact frame index
                polygon_5.setAutoDraw(True)
            frameRemains = 0.0 + 1.0- win.monitorFramePeriod * 0.75  # most of one frame period left
            if polygon_5.status == STARTED and t >= frameRemains:
                polygon_5.setAutoDraw(False)
            
            
            # check if all components have finished
            if not continueRoutine:  # a component has requested a forced-end of Routine
                break
            continueRoutine = False  # will revert to True if at least one component still running
            for thisComponent in fixationComponents:
                if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                    continueRoutine = True
                    break  # at least one component has not yet finished
            
            # check for quit (the Esc key)
            if endExpNow or event.getKeys(keyList=["escape"]):
                core.quit()
            
            # refresh the screen
            if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
                win.flip()
        
        # -------Ending Routine "fixation"-------
        for thisComponent in fixationComponents:
            if hasattr(thisComponent, "setAutoDraw"):
                thisComponent.setAutoDraw(False)
        myequal = 0
    # completed number_of_fixational_trials repeats of 'trials'
    
    
    # set up handler to look after randomisation of conditions etc
    trials_3 = data.TrialHandler(nReps=100, method='random', 
        extraInfo=expInfo, originPath=-1,
        trialList=[None],
        seed=None, name='trials_3')
    thisExp.addLoop(trials_3)  # add the loop to the experiment
    thisTrial_3 = trials_3.trialList[0]  # so we can initialise stimuli with some values
    # abbreviate parameter names if possible (e.g. rgb = thisTrial_3.rgb)
    if thisTrial_3 != None:
        for paramName in thisTrial_3.keys():
            exec(paramName + '= thisTrial_3.' + paramName)
    
    for thisTrial_3 in trials_3:
        currentLoop = trials_3
        # abbreviate parameter names if possible (e.g. rgb = thisTrial_3.rgb)
        if thisTrial_3 != None:
            for paramName in thisTrial_3.keys():
                exec(paramName + '= thisTrial_3.' + paramName)
        
        # ------Prepare to start Routine "test"-------
        t = 0
        testClock.reset()  # clock
        frameN = -1
        continueRoutine = True
        # update component parameters for each repeat
        answer = event.BuilderKeyResponse()
        
        # keep track of which components have finished
        testComponents = [polygon_3, polygon_4, answer, text, polygon_6]
        for thisComponent in testComponents:
            if hasattr(thisComponent, 'status'):
                thisComponent.status = NOT_STARTED
        
        # -------Start Routine "test"-------
        while continueRoutine:
            # get current time
            t = testClock.getTime()
            frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
            # update/draw components on each frame
            
            # *polygon_3* updates
            if t >= 0.6 and polygon_3.status == NOT_STARTED:
                # keep track of start time/frame for later
                polygon_3.tStart = t
                polygon_3.frameNStart = frameN  # exact frame index
                polygon_3.setAutoDraw(True)
            frameRemains = 0.6 + 0.15- win.monitorFramePeriod * 0.75  # most of one frame period left
            if polygon_3.status == STARTED and t >= frameRemains:
                polygon_3.setAutoDraw(False)
            
            # *polygon_4* updates
            if t >= 0.6 and polygon_4.status == NOT_STARTED:
                # keep track of start time/frame for later
                polygon_4.tStart = t
                polygon_4.frameNStart = frameN  # exact frame index
                polygon_4.setAutoDraw(True)
            frameRemains = 0.6 + 0.15- win.monitorFramePeriod * 0.75  # most of one frame period left
            if polygon_4.status == STARTED and t >= frameRemains:
                polygon_4.setAutoDraw(False)
            
            # *answer* updates
            if t >= 0.8 and answer.status == NOT_STARTED:
                # keep track of start time/frame for later
                answer.tStart = t
                answer.frameNStart = frameN  # exact frame index
                answer.status = STARTED
                # keyboard checking is just starting
                win.callOnFlip(answer.clock.reset)  # t=0 on next screen flip
                event.clearEvents(eventType='keyboard')
            if answer.status == STARTED:
                theseKeys = event.getKeys(keyList=['left', 'right', 'down'])
                
                # check for quit:
                if "escape" in theseKeys:
                    endExpNow = True
                if len(theseKeys) > 0:  # at least one key was pressed
                    answer.keys = theseKeys[-1]  # just the last key pressed
                    answer.rt = answer.clock.getTime()
                    # a response ends the routine
                    continueRoutine = False
            
            # *text* updates
            if t >= 0.8 and text.status == NOT_STARTED:
                # keep track of start time/frame for later
                text.tStart = t
                text.frameNStart = frameN  # exact frame index
                text.setAutoDraw(True)
            
            # *polygon_6* updates
            if t >= 0.0 and polygon_6.status == NOT_STARTED:
                # keep track of start time/frame for later
                polygon_6.tStart = t
                polygon_6.frameNStart = frameN  # exact frame index
                polygon_6.setAutoDraw(True)
            frameRemains = 0.0 + 0.6- win.monitorFramePeriod * 0.75  # most of one frame period left
            if polygon_6.status == STARTED and t >= frameRemains:
                polygon_6.setAutoDraw(False)
            
            
            # check if all components have finished
            if not continueRoutine:  # a component has requested a forced-end of Routine
                break
            continueRoutine = False  # will revert to True if at least one component still running
            for thisComponent in testComponents:
                if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                    continueRoutine = True
                    break  # at least one component has not yet finished
            
            # check for quit (the Esc key)
            if endExpNow or event.getKeys(keyList=["escape"]):
                core.quit()
            
            # refresh the screen
            if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
                win.flip()
        
        # -------Ending Routine "test"-------
        for thisComponent in testComponents:
            if hasattr(thisComponent, "setAutoDraw"):
                thisComponent.setAutoDraw(False)
        # check responses
        if answer.keys in ['', [], None]:  # No response was made
            answer.keys=None
        trials_3.addData('answer.keys',answer.keys)
        if answer.keys != None:  # we had a response
            trials_3.addData('answer.rt', answer.rt)
        if answer.keys == "down":
            myequal += 1
        elif answer.keys != "down":
            myequal = 0
        if myequal >= 3:
            break
        # the Routine "test" was not non-slip safe, so reset the non-slip timer
    # completed 100 repeats of 'trials_3'
    
    
    # ------Prepare to start Routine "rest"-------
    t = 0
    restClock.reset()  # clock
    frameN = -1
    continueRoutine = True
    # update component parameters for each repeat
    key_resp_4 = event.BuilderKeyResponse()
    # keep track of which components have finished
    restComponents = [text_3, key_resp_4]
    for thisComponent in restComponents:
        if hasattr(thisComponent, 'status'):
            thisComponent.status = NOT_STARTED
    
    # -------Start Routine "rest"-------
    while continueRoutine:
        # get current time
        t = restClock.getTime()
        frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
        # update/draw components on each frame
        
        # *text_3* updates
        if t >= 0.0 and text_3.status == NOT_STARTED:
            # keep track of start time/frame for later
            text_3.tStart = t
            text_3.frameNStart = frameN  # exact frame index
            text_3.setAutoDraw(True)
        
        # *key_resp_4* updates
        if t >= 0.0 and key_resp_4.status == NOT_STARTED:
            # keep track of start time/frame for later
            key_resp_4.tStart = t
            key_resp_4.frameNStart = frameN  # exact frame index
            key_resp_4.status = STARTED
            # keyboard checking is just starting
            event.clearEvents(eventType='keyboard')
        if key_resp_4.status == STARTED:
            theseKeys = event.getKeys(keyList=['space'])
            
            # check for quit:
            if "escape" in theseKeys:
                endExpNow = True
            if len(theseKeys) > 0:  # at least one key was pressed
                # a response ends the routine
                continueRoutine = False
        
        # check if all components have finished
        if not continueRoutine:  # a component has requested a forced-end of Routine
            break
        continueRoutine = False  # will revert to True if at least one component still running
        for thisComponent in restComponents:
            if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
                continueRoutine = True
                break  # at least one component has not yet finished
        
        # check for quit (the Esc key)
        if endExpNow or event.getKeys(keyList=["escape"]):
            core.quit()
        
        # refresh the screen
        if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
            win.flip()
    
    # -------Ending Routine "rest"-------
    for thisComponent in restComponents:
        if hasattr(thisComponent, "setAutoDraw"):
            thisComponent.setAutoDraw(False)
    # the Routine "rest" was not non-slip safe, so reset the non-slip timer
    routineTimer.reset()
# completed 2 repeats of 'trials_2'


# ------Prepare to start Routine "thank_you"-------
t = 0
thank_youClock.reset()  # clock
frameN = -1
continueRoutine = True
routineTimer.add(5.000000)
# update component parameters for each repeat
# keep track of which components have finished
thank_youComponents = [text_4]
for thisComponent in thank_youComponents:
    if hasattr(thisComponent, 'status'):
        thisComponent.status = NOT_STARTED

# -------Start Routine "thank_you"-------
while continueRoutine and routineTimer.getTime() > 0:
    # get current time
    t = thank_youClock.getTime()
    frameN = frameN + 1  # number of completed frames (so 0 is the first frame)
    # update/draw components on each frame
    
    # *text_4* updates
    if t >= 0.0 and text_4.status == NOT_STARTED:
        # keep track of start time/frame for later
        text_4.tStart = t
        text_4.frameNStart = frameN  # exact frame index
        text_4.setAutoDraw(True)
    frameRemains = 0.0 + 5.0- win.monitorFramePeriod * 0.75  # most of one frame period left
    if text_4.status == STARTED and t >= frameRemains:
        text_4.setAutoDraw(False)
    
    # check if all components have finished
    if not continueRoutine:  # a component has requested a forced-end of Routine
        break
    continueRoutine = False  # will revert to True if at least one component still running
    for thisComponent in thank_youComponents:
        if hasattr(thisComponent, "status") and thisComponent.status != FINISHED:
            continueRoutine = True
            break  # at least one component has not yet finished
    
    # check for quit (the Esc key)
    if endExpNow or event.getKeys(keyList=["escape"]):
        core.quit()
    
    # refresh the screen
    if continueRoutine:  # don't flip if this routine is over or we'll get a blank screen
        win.flip()

# -------Ending Routine "thank_you"-------
for thisComponent in thank_youComponents:
    if hasattr(thisComponent, "setAutoDraw"):
        thisComponent.setAutoDraw(False)


# these shouldn't be strictly necessary (should auto-save)
thisExp.saveAsWideText(filename+'.csv')
thisExp.saveAsPickle(filename)
logging.flush()
# make sure everything is closed down
thisExp.abort()  # or data files will save again on exit
win.close()
core.quit()
